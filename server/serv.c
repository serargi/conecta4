#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>
#include <signal.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>

#define MAX 1024


int r_socket,r_bind,r_listen,r_accept,addrlen,r_lista,r_conectados,r_partidas,r_exit,r_tirada;
int pid,pid_hijo,pid_padre,m,cont=0,cero=0,fl,num_pipe;
char buff[MAX],usuario[13],usuario2[13],lock[30];

struct sockaddr_in ellos;
struct sockaddr_in nos;





void notifica_off(char usuario[])
{
int i,lineas,canal,z;
char mensaje[MAX],recortado[13];


strncpy(recortado,usuario,12);
lineas=(lseek(r_conectados,0,SEEK_END))/25; //lineas que tiene conectados.txt
for (z=0;z<12;z++)
{
if (recortado[z]==' ')
recortado[z]='\0';
}
for (i=0;i<lineas;i++)
{
lseek(r_conectados,((i*25)+12),SEEK_SET);
read(r_conectados,&canal,4);
if ((canal>0) && (canal<300))
  {
      if (WEXITSTATUS(r_exit)==2) //sale normalmente
      {
      sprintf(mensaje,"99Se ha desconectado %s",recortado); 
      num_pipe=canal;
      write(canal,mensaje,strlen(mensaje));
      write(1,mensaje,strlen(mensaje));
      write(1,"\n",1);
      }
      if (WEXITSTATUS(r_exit)==5) //alarm
      {
      sprintf(mensaje,"99Se ha desconectado %s por timeout",recortado); 
      num_pipe=canal;
      write(canal,mensaje,strlen(mensaje));
      write(1,mensaje,strlen(mensaje));
      write(1,"\n",1);
      }
      if (WEXITSTATUS(r_exit)==0) //pipe
      {
      sprintf(mensaje,"99Se ha desconectado %s por fallo en su conexion",recortado);
      num_pipe=canal;
      write(canal,mensaje,strlen(mensaje));
      write(1,mensaje,strlen(mensaje));
      write(1,"\n",1);
      }
  }
}
} 

void notifica_on()
{
int canal,can,fd;
char mensaje[MAX], busca[13],tmp[13],us[13],envia[MAX],respuesta[2];


fd=open("tmp.txt.lock",O_EXCL|O_CREAT,0777);
if (fd==-1)
{
write(1,"Estoy en el signal de reto\n",27);
//fl= open("tmp.txt",O_RDWR|O_APPEND|O_CREAT,0777); 21 de enero
fl= open("tmp.txt",O_RDWR|O_CREAT,0766);
read(fl,busca,12);
read(fl,respuesta,1);
respuesta[1]='\0';
read(fl,us,12);
us[12]='\0';

  lseek(r_conectados,0,SEEK_SET);
  while ((read(r_conectados,tmp,12))>0)
  {

    if (strncmp(busca,tmp,12)==0)
    	{
      read(r_conectados,&can,4);
        sprintf (envia,"05%s %s",respuesta,us); //reto r/a por us
        num_pipe=can;
        write(can,envia,16); //4+12
        write(1,envia,16);
        write(1,"\n",1);
        close (fl);
        unlink("tmp.txt");
        unlink("tmp.txt.lock");
        }
    
     lseek(r_conectados,+13,SEEK_CUR);
    
    }

}
else
{
close (fd);
unlink("tmp.txt.lock");
lseek(r_conectados,-25,SEEK_END);
read(r_conectados,usuario,12);
sprintf(mensaje,"99Se ha conectado %s",usuario);

lseek(r_conectados,12,SEEK_SET);
while(read(r_conectados,&canal,4)>0)
{
if ((canal>0) && (canal<300))
  {
  num_pipe=canal;
  write(canal,mensaje,30);
  write(1,mensaje,30);
  write(1,"\n",1);
  }
lseek(r_conectados,+21,SEEK_CUR);
}
}//final de else

}

int decrementa_partidas (char busca [])
{
int l;
char tmp[13];


fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
   while (fl==-1)
   {
   perror("Error Open. El archivo de entrada esta bloqueado\n");
   sleep(1);
   fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
   }


lseek(r_conectados,0,SEEK_SET);

while((read(r_conectados,tmp,12))>0)
{
  if ((strncmp(busca,tmp,12))==0)
  {
  lseek(r_conectados,+8,SEEK_CUR);
  read(r_conectados,&l,4);
      if (l!=0)
        {
        //sprintf(buff,"Primero tienes %d\n",l);
        //write(1,buff,strlen(buff));
        l=l-1;
        lseek(r_conectados,-4,SEEK_CUR);		
        write(r_conectados,&l,4);
        lseek(r_conectados,+1,SEEK_CUR);
        //sprintf(buff,"Luego tienes %d\n",l);
        //write(1,buff,strlen(buff));
        }
  close(fl);
  unlink("conectados.txt.lock");
  return 0;
  }
  
lseek(r_conectados,+13,SEEK_CUR);
}

close(fl);
unlink("conectados.txt.lock");
return -1;
}



int busca_conectado(char busca[])
{
char tmp[13];

lseek(r_conectados,0,SEEK_SET);

while((read(r_conectados,tmp,12))>0)
{
  if ((strncmp(busca,tmp,12))==0)
  return -1;
  
lseek(r_conectados,+13,SEEK_CUR);
}
return 0;
}

int borra_partidas(char borrame[])
{
int t,can,z;
char busca[13],car[2],decrementa[13],borrame2[13],decrementa2[13],mensaje[MAX];
borrame[12]='\0';

  fl= open("partidas.txt.lock",O_EXCL|O_CREAT,0777);
   while (fl==-1)
   {
   perror("Error Open. El archivo de entrada esta bloqueado\n");
   sleep(1);
   fl= open(lock,O_EXCL|O_CREAT,0777);
   }

lseek(r_partidas,0,SEEK_SET);

while((read(r_partidas,busca,12)>0))
{
  if ((strncmp(borrame,busca,12))==0)
    {
     read(r_partidas,car,1);
    if ((strncmp(car," ",1))==0)
     {
     read(r_partidas,decrementa,12);
     decrementa[12]='\0';
     lseek(r_partidas,-25,SEEK_CUR);
     write(r_partidas,"                         ",25);
     decrementa_partidas(decrementa);

         //le digo al contra el que jugaba que gana por retiro (desconexion)
         busca_conectado(decrementa);
         read(r_conectados,&can,4);

        if (WEXITSTATUS(r_exit)==5) //sales por alarma timeout
        {
        sprintf(mensaje,"08%s0A",borrame);        
        }
        else //sales por desconexion normal o pipe rota
        {
        sprintf(mensaje,"08%s0R",borrame);        
        }

         num_pipe=can;
         write(can,mensaje,16);
         //ahora le digo a todos el resultado de la partida
        //NOTIFICAR A TODOS QUE HE PERDIDO LA PARTIDA POR RETIRO
                   strncpy(decrementa2,decrementa,12);
                   strncpy(borrame2,borrame,12);
                   for (z=0;z<12;z++)
                    {
                    if (borrame2[z]==' ')
                    borrame2[z]='\0';
                    }
                    
                   for (z=0;z<12;z++)
                    {
                    if (decrementa2[z]==' ')
                    decrementa2[z]='\0';
                    }
                   borrame2[12]='\0';
                   decrementa2[12]='\0'; 
        lseek(r_conectados,12,SEEK_SET);
        if (WEXITSTATUS(r_exit)==5)//sales por alarma timeout
        {
        sprintf(mensaje,"99%s gana a %s por timeout",decrementa2,borrame2);        
        }
        else //sales por desconexion normal o pipe rota
        {
        sprintf(mensaje,"99%s gana a %s por retiro",decrementa2,borrame2);        
        }
        sleep(1);
            while(read(r_conectados,&can,4)>0)
            {
              if ((can>0) && (can<300))
                {
                num_pipe=can;
                write(can,mensaje,strlen(mensaje));
                }
              lseek(r_conectados,+21,SEEK_CUR);
            }
        
     }//final de if " "
    if ((strncmp(car,"R",1))==0)
     {
     read(r_partidas,decrementa,12);
     lseek(r_partidas,-25,SEEK_CUR);
     write(r_partidas,"                         ",25);
     } 
    if ((strncmp(car,"\n",1))==0)
     {
     t=lseek(r_partidas,-26,SEEK_CUR);
     read(r_partidas,decrementa,12);
     read(r_partidas,car,1);
     lseek(r_partidas,t,SEEK_SET);
     write(r_partidas,"                         ",25);
          if ((strncmp(car," ",1))==0)
          { 
               t=decrementa_partidas(decrementa);
                  //le digo al contra el que jugaba que gana por retiro (desconexion)
                   busca_conectado(decrementa);
                   read(r_conectados,&can,4);
                      if (WEXITSTATUS(r_exit)==5) //sales por alarma timeout
                      {
                      sprintf(mensaje,"08%s0A",borrame);        
                      }
                      else //sales por desconexion normal o pipe rota
                      {
                      sprintf(mensaje,"08%s0R",borrame);        
                      }
                   num_pipe=can;
                   write(can,mensaje,strlen(mensaje));
                   //ahora le digo a todos el resultado de la partida
                   //NOTIFICAR A TODOS QUE HE PERDIDO LA PARTIDA POR RETIRO

                   strncpy(decrementa2,decrementa,12);
                   strncpy(borrame2,borrame,12);
                   for (z=0;z<12;z++)
                    {
                    if (borrame2[z]==' ')
                    borrame2[z]='\0';
                    }
                    
                   for (z=0;z<12;z++)
                    {
                    if (decrementa2[z]==' ')
                    decrementa2[z]='\0';
                    }
                   borrame2[12]='\0';
                   decrementa2[12]='\0';
                   
                   lseek(r_conectados,12,SEEK_SET);
                    if (WEXITSTATUS(r_exit)==5)//sales por alarma timeout
                    {
                    sprintf(mensaje,"99%s gana a %s por timeout",decrementa2,borrame2);        
                    }
                    else //sales por desconexion normal o pipe rota
                    {
                    sprintf(mensaje,"99%s gana a %s por retiro",decrementa2,borrame2);        
                    }
                    sleep(1);
                      while(read(r_conectados,&can,4)>0)
                      {
                        if ((can>0) && (can<300))
                          {
                          num_pipe=can;
                          write(can,mensaje,strlen(mensaje));
                          }
                        lseek(r_conectados,+21,SEEK_CUR);
                      }
          }
          else //R
          {
           busca_conectado(decrementa);
           read(r_conectados,&can,4);
           sprintf(mensaje,"05El reto ha sido cancelado por desconexion de %s",borrame);
           num_pipe=can;
           write(can,mensaje,59);           
          }
     }
  
    }
    lseek(r_partidas,+1,SEEK_CUR);
}

unlink("partidas.txt.lock"); //final del lock
return 0;
}

int borra_usuario(int pid)
{
int num,t;
char desc[13];

    //Comprueba archivo lock
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
       while (fl==-1)
       {
       perror("Error Open. El archivo de entrada esta bloqueado\n");
       sleep(1);
       fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
       }


lseek(r_conectados,16,SEEK_SET);
while(read(r_conectados,&num,4)>0)
{
  if (num==pid)
	{
	lseek(r_conectados,-20,SEEK_CUR);
	read(r_conectados,desc,12);
	read(r_conectados,&m,4);
  write(1,desc,12);
  write(1,"<- Usuario borrado de conectados.txt\n",37);
  t=lseek(r_conectados,-16,SEEK_CUR);
  write(r_conectados,"                        ",24);
  close(m);
  notifica_off(desc);
  close(fl);
  unlink("conectados.txt.lock");
	borra_partidas(desc);
  return t;//posicion donde empieza la linea borrada
	}
lseek(r_conectados,+21,SEEK_CUR);
}
   
    //final de lock
    close(fl);
    unlink("conectados.txt.lock");
    
write(1,"No hay usuario para borrar\n",27);
return -1;

}


int registrar_usuario(int m)
{
char compara[13];

//Archivo de bloqueo
sprintf(lock,"%s.lock","lista.txt");

//Comprueba archivo lock
fl= open(lock,O_EXCL|O_CREAT,0777);
   while (fl==-1)
   {
   perror("Error Open. El archivo de entrada esta bloqueado\n");
   sleep(1);
   fl= open(lock,O_EXCL|O_CREAT,0777);
   }
//final de lock

read(m,buff,12);//usuario
lseek(r_lista,0,SEEK_SET);

while (read(r_lista,compara,12)>0)
{
	if((strncmp(compara,buff,12))==0)
	{
	read(m,buff,12); //para vaciar el socket
	close (fl);
  unlink(lock);
  return -1;
	}
	lseek(r_lista,+13,SEEK_CUR);
}

strncpy(usuario,buff,12);
read(m,buff,12);//password
write(r_lista,usuario,12);
write(r_lista,buff,12);
write(r_lista,"\n",1);
close (fl);
unlink(lock);

    //Comprueba archivo lock
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    }
    
        lseek(r_conectados,0,SEEK_END);
        write(r_conectados,usuario,12);
        write(r_conectados,&m,4);
        write(r_conectados,&pid_hijo,4);
        write(r_conectados,&cero,4);
        write(r_conectados,"\n",1);
 
    close(fl);
    unlink("conectados.txt.lock");
    //Final archivo lock

kill (pid_padre, SIGUSR1);
return 0;
}

void dame_conectados(int m)
{
int partidas;
char users[13],envia[MAX];

lseek(r_conectados,0,SEEK_SET);
while((read(r_conectados,users,12))>0)
{
  
  if ((strncmp(users,"            ",12)!=0))
  {
  users[12]='\0';
  lseek(r_conectados,+8,SEEK_CUR);
  read(r_conectados,&partidas,4);
  lseek(r_conectados,-12,SEEK_CUR);
    if ((partidas>=0) && (partidas<10))
    {
    sprintf(envia,"03%s%d ",users,partidas);
    write(1,envia,strlen(envia));
    write(1,"\n",1);
    num_pipe=m;
    write(m,envia,16);
    }
    if (partidas>9)
    {
    sprintf(envia,"03%s%d",users,partidas);
    write(1,envia,strlen(envia));
    write(1,"\n",1);
    num_pipe=m;
    write(m,envia,16);
    }
    if (partidas<0)
    {
    write(1,"\t error\n",8);
    sprintf(envia,"Error con el usuario: %s -> pone que tiene %d partidas",users,partidas);
    write(1,envia,strlen(envia));
    write(1,"\n",1);
    }
  }
  lseek(r_conectados,+13,SEEK_CUR);
}

}



int comprueba_usuario(int m)
{
int t,i,r,fl2;
char lock2[30],tira[25];

    sprintf(lock2,"%s.lock","lista.txt");
    //Comprueba archivo lock
    fl2= open(lock2,O_EXCL|O_CREAT,0777);
    while (fl2==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl2= open(lock2,O_EXCL|O_CREAT,0777);
    }
    //Archivo de bloqueo2
    sprintf(lock,"%s.lock","conectados.txt");
    //Comprueba archivo lock
    fl= open(lock,O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open(lock,O_EXCL|O_CREAT,0777);
    }
    //final de lock

read(m,buff,24);    	
lseek(r_lista,0,SEEK_SET);


while((read(r_lista,tira,24))>0)
{
if ((strncmp(tira,buff,24))==0)
	{
	strncpy(usuario,buff,12);
  t=lseek(r_lista,0,SEEK_CUR);
	r=busca_conectado(usuario);
	   if (r==-1)
        {
        for (i=0;i<13;i++) //ahora 'vaciare' el string usuario[]
        {
        usuario[i]='\0';
        }
        close (fl);
        unlink(lock);
	      close (fl2);
        unlink(lock2);
        return -2; //usuario ON en este momento
        }
    if (r==0) //El usuario no está en conectados.txt
	  {
    
    close (fl2);
    unlink(lock2);
    lseek(r_conectados,0,SEEK_END);
		write(r_conectados,usuario,12);//usuario
		write(r_conectados,&m,4);//canal
		write(r_conectados,&pid_hijo,4);//pid del hijo
		write(r_conectados,&cero,4);//partidas
    write(r_conectados,"\n",1);
    
    kill (pid_padre, SIGUSR1);
    close (fl);
    unlink(lock);

    return t;
		}
	}
t=lseek(r_lista,0,SEEK_CUR);
lseek(r_lista,t+1,SEEK_SET);
}
//si llego a este punto es que el usuario no está en la base de datos
close (fl);
unlink(lock);
close (fl2);
unlink(lock2);
return -1;
}



int conecta(int r_socket)
{
//addrlen = sizeof(struct sockaddr_in);
addrlen = sizeof(ellos);
r_accept = accept(r_socket, (struct sockaddr *)&ellos,&addrlen);
        if (r_accept==-1)
                return (-1);


return(r_accept);
}

void muere_hijo() 
{
pid=wait(&r_exit);

printf ("Wait devuelve %d\n",WEXITSTATUS(r_exit));
printf("Muere el hijo con PiD %d\n",pid);
borra_usuario(pid);

}

int reta()
{
    int t,i;
    char usuarios1[27],usuarios2[27],usuarios3[27],usuarios4[27],tmp[13];
    bool encontrado;
    encontrado=false;
    
    //Archivo de bloqueo
    sprintf(lock,"%s.lock","partidas.txt");
    //Comprueba archivo lock
    fl= open(lock,O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open(lock,O_EXCL|O_CREAT,0777);
    }

    //comprueba que este conectado
      lseek(r_conectados,0,SEEK_SET);
      
      while(read(r_conectados,tmp,12)>0)
      {
        if ((strncmp(usuario2,tmp,12))==0)
        {
        encontrado=true;
        }
               
      lseek(r_conectados,+13,SEEK_CUR);
      }
      
      if (encontrado==false)
      {
      close(fl);
      unlink(lock);
      return -2;
      }
      
    strncpy(tmp,usuario,12);
    tmp[12]='\0';
    usuario2[12]='\0';
    
    t=lseek(r_partidas,0,SEEK_END);
    lseek(r_partidas,0,SEEK_SET);
    

    sprintf(usuarios1,"%s %s",tmp,usuario2);
    sprintf(usuarios2,"%s %s",usuario2,tmp);
    sprintf(usuarios3,"%sR%s",tmp,usuario2);
    sprintf(usuarios4,"%sR%s",usuario2,tmp);

    for (i=0;i<t/26;i++)
     {
     read(r_partidas,buff,25);
     if (((strncmp(usuarios1,buff,25))==0) || ((strncmp(usuarios2,buff,25))==0) || ((strncmp(usuarios3,buff,25))==0) || ((strncmp(usuarios4,buff,25))==0))
     {
     close (fl);
     unlink(lock); //final de lock
     return -1;
     }
          
     lseek(r_partidas,+1,SEEK_CUR);
    }
     
      write (r_partidas,usuario,12);
      write (r_partidas,"R",1);
      write (r_partidas,usuario2,12);
      write (r_partidas,"\n",1);

    kill (pid_padre, SIGUSR2);
    close (fl);
    unlink(lock); //final de lock
    return 0;
    
}

void retalos ()
{

int q,r,m1,m2;
char us1[12],us2[12],tmp[12],envia[MAX];

lseek(r_partidas,-26,SEEK_CUR);
read(r_partidas,us1,12);
lseek(r_partidas,+1,SEEK_CUR);
read(r_partidas,us2,12);


lseek(r_conectados,0,SEEK_SET);

r=read(r_conectados,tmp,12);
while(r>0)
{
q=strncmp(us2,tmp,12);
if (q==0)
	{
  read(r_conectados,&m2,4);
  lseek(r_conectados,0,SEEK_SET);
  }
  
lseek(r_conectados,+13,SEEK_CUR);
r=read(r_conectados,tmp,12);
}
lseek(r_conectados,0,SEEK_SET);

r=read(r_conectados,tmp,12);
while(r>0)
{
if ((q=strncmp(us1,tmp,12))==0);
	{
  read(r_conectados,&m1,4);
  }  
lseek(r_conectados,+13,SEEK_CUR);
r=read(r_conectados,tmp,12);

}

sprintf (envia,"04Te Reta %s",us1);
num_pipe=m2;
write(m2,envia,22);


}


int rechaza (char * tmp) //borra de partidas.txt la partida rechazada
{
char usuarios1[26],usuarios2[26];

    //Archivo de bloqueo
    sprintf(lock,"%s.lock","partidas.txt");
    //Comprueba archivo lock
    fl= open(lock,O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl=open(lock,O_EXCL|O_CREAT,0777);
    }

lseek(r_partidas,0,SEEK_SET);
sprintf(usuarios2,"%sR%s",usuario2,tmp);
sprintf(usuarios1,"%sR%s",tmp,usuario2);


while((read(r_partidas,buff,25)>0))
 {
     if (((strncmp(usuarios1,buff,25))==0) || ((strncmp(usuarios2,buff,25))==0))
     {
     lseek(r_partidas,-25,SEEK_CUR);
     write(r_partidas,"                         ",25);
     return 0;
     }
     lseek(r_partidas,+1,SEEK_CUR);
 }
  return -1;
}


int suma_partida (char *  A)
{
int l;
char busca[13],suma[3];

lseek(r_conectados,0,SEEK_SET);
while(read(r_conectados,busca,12)>0)
{
	if (strncmp(A,busca,12)==0)
		{
		lseek(r_conectados,+8,SEEK_CUR);		
		read(r_conectados,&l,4);
		sprintf(suma,"%d",l);
		suma[2]='\0';		
		l=l+1;
		lseek(r_conectados,-4,SEEK_CUR);		
		write(r_conectados,&l,4);
		sprintf(suma,"%d",l);
		suma[2]='\0';		
		write(1,"Partida incrementada con exito\n",31);
    return 0;
		}
		lseek(r_conectados,+13,SEEK_CUR);

}
write(1,"Error incrementando partidas\n",29);
return -1;
}

void fin_partida()
{
int can,fl,lineas,canal,z;
char ganador[13],rival[13],columna[2],final[2],mensaje[MAX],busqueda[26],partida1[26],partida2[26];

lseek(r_tirada,0,SEEK_SET);
read(r_tirada,&can,4);
read(r_tirada,ganador,12);
read(r_tirada,rival,12);
read(r_tirada,columna,1);
read(r_tirada,final,1);
rival[12]='\0';
ganador[12]='\0';
columna[1]='\0';
final[1]='\0';
sprintf(mensaje,"08%s%s%s",ganador,columna,final);
//write(1,"\tposible problema\n",18);
num_pipe=can;
write(can,mensaje,16);
//write(1,mensaje,16);
//write(1,"\n",1);


unlink ("tirada.txt.lock");

//borro la partida recien acabada
fl= open("partidas.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("partidas.txt.lock",O_EXCL|O_CREAT,0777);
    }

sprintf (partida1,"%s %s",ganador,rival);
sprintf (partida2,"%s %s",rival,ganador);

lseek(r_partidas,0,SEEK_SET);
while(read(r_partidas,busqueda,25)>0)
{
     if (((strncmp(partida1,busqueda,25))==0) || ((strncmp(partida2,busqueda,25))==0))
     {
     lseek(r_partidas,-25,SEEK_CUR);
     write(r_partidas,"                         ",25);
     }
     lseek(r_partidas,+1,SEEK_CUR);

}
close(fl);
unlink ("partidas.txt.lock");

decrementa_partidas(ganador);
decrementa_partidas(rival);

//ahora notifico a todos

    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    }


for (z=0;z<12;z++)
{
if (ganador[z]==' ')
ganador[z]='\0';
if (rival[z]==' ')
rival[z]='\0';
}
if (strncmp("T",final,1)==0)//tablas
{
sprintf(mensaje,"99%s y %s empatan su partida",ganador,rival);
//mensaje[48]='\0';
}
if (strncmp("R",final,1)==0)//retiro
{
sprintf(mensaje,"99%s gana a %s por retiro",rival,ganador);
//mensaje[44]='\0';
}
if (strncmp("P",final,1)==0)//perdido
{
sprintf(mensaje,"99%s gana a %s por 4 en raya",ganador,rival);
//mensaje[48]='\0';
}

lineas=(lseek(r_conectados,0,SEEK_END))/25; //lineas que tiene conectados.txt
write(1,"\n",1);
write(1,"Notifico fin partida\n",21);

for (z=0;z<lineas;z++)
{
lseek(r_conectados,((z*25)+12),SEEK_SET);
read(r_conectados,&canal,4);
if ((canal>0) && (canal<300))
  {
  num_pipe=canal;
  write(canal,mensaje,strlen(mensaje));
  write(1,mensaje,strlen(mensaje));
  write(1,"\n",1);
  }
}

close(fl);
unlink("conectados.txt.lock");
}

void salida_forzosa()
{
int canal,pid_pipe;
char usuario_pipe[13];

write(1,"Salida forzosa\n",15);
usuario_pipe[12]='\0';
lseek(r_conectados,12,SEEK_SET);

while(read(r_conectados,&canal,4)>0)
{
    if (canal==num_pipe)
    {
    read(r_conectados,&pid_pipe,4);
    lseek(r_conectados,-20,SEEK_CUR);
    read(r_conectados,usuario_pipe,12);
    lseek(r_conectados,+4,SEEK_CUR);
    }
  lseek(r_conectados,+21,SEEK_CUR);
}
//cuando llego aqui ya se quien tiene la pipe rota usuario_pipe y su pid_pipe
kill(pid_pipe,SIGKILL); //hago que termine y saltara SIGCHLD
}

void alarma ()
{
cont++;
printf("cont= %d\n",cont);
    if (cont==5)
    {
    write(1,"Salta la alarma\n",16);
    exit(5);
    }
alarm (60);
}

void dile_sorteo ()
{
int fd;

      write(1,"Estoy en el signal de sorteo\n",29);
      fd=open("sorteo.txt",O_RDWR);
      read(fd,buff,26);
      num_pipe=m;
      write(m,buff,26);
      close (fd);
      unlink("sorteo.txt");

}

void tirada()
{
char rival[13],columna[2],mensaje[MAX];

lseek(r_tirada,0,SEEK_SET);
read(r_tirada,rival,12);
rival[12]='\0';
read(r_tirada,columna,1);
columna[1]='\0';

sprintf(mensaje,"07%s%s",rival,columna);
mensaje[15]='\0';
//write(1,mensaje,15);
//write(1,"\n",1);
num_pipe=m;
write(m,mensaje,15);
unlink ("tirada.txt.lock");

}


void sorteo(char rival[])
{
int r,l2,numero,pid_rival;
char tmp[13];


lseek(r_conectados,0,SEEK_SET);
while((read(r_conectados,tmp,12))>0)
{
       if ((strncmp(rival,tmp,12))==0)
       {
       read(r_conectados,&l2,4);
       read(r_conectados,&pid_rival,4);
       }
    
    lseek(r_conectados,+13,SEEK_CUR);
}


numero = rand () % 2;   // Estara entre 0 y 1
printf ("Sale el numero(random): %d\n",numero);

if (numero==0)
{
write (1,"saca ",5);
write (1,usuario,strlen(usuario));
write (1,"\n",1);
sprintf(buff,"06%s%s",usuario,rival);
}

if (numero==1)
{
write (1,"saca ",5);
write (1,rival,strlen(rival));
write (1,"\n",1);
sprintf(buff,"06%s%s",rival,usuario);
}

unlink ("conectados.txt.lock");


    fl= open("sorteo.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("sorteo.txt.lock",O_EXCL|O_CREAT,0777);
    }

r=open("sorteo.txt",O_RDWR|O_TRUNC|O_CREAT,0766);


num_pipe=m;
write(m,buff,strlen(buff));//se lo mando al que ha retado
write(r,buff,strlen(buff));//lo escribo en sorteo.txt
write(1,buff,strlen(buff));//lo escribo por pantalla
write(1,"\n",1);

close(r);
kill(pid_rival,SIGTRAP);
close (fl);
unlink("sorteo.txt.lock");
}


int main ()
{
int i,r,s;
char tmp[13],buscando[MAX];


if((unlink("partidas.txt.lock")==0) || (unlink("conectados.txt.lock")==0) || (unlink("lista.txt.lock")==0) || (unlink("sorteo.txt.lock")==0) || (unlink("tmp.txt.lock")==0) || (unlink("tirada.txt.lock")==0))
{
write (1,"ERROR RESUELTO\n",15);//Habia locks en el directorio raiz
write (1,"La anterior ejecucion del servidor no acabo de manera correcta\n",63);
}

nos.sin_family = AF_INET;
nos.sin_port = htons(50412);
nos.sin_addr.s_addr = INADDR_ANY;
memset(&(nos.sin_zero), 0, 8);

unlink("partidas.txt");
unlink("conectados.txt");
unlink("tirada.txt");
unlink("tmp.txt");
unlink("sorteo.txt");


r_lista=open("lista.txt",O_RDWR|O_APPEND|O_CREAT,0766);
	if (r_lista==-1)
		{
		perror ("error creando r_lista");
		return 0;
		}

r_conectados=open("conectados.txt",O_RDWR|O_CREAT,0766);
	if (r_conectados==-1)
		{
		perror ("error creando r_conectados");
		return 0;
		}
		
r_partidas=open("partidas.txt",O_RDWR|O_CREAT,0766);
	if (r_lista==-1)
		{
		perror ("error creando r_partidas");
		return 0;
		}
		
r_tirada=open("tirada.txt",O_RDWR|O_CREAT,0766);
	if (r_tirada==-1)
		{
		perror ("error creando r_tirada");
		return 0;
		}		

r_socket=socket(AF_INET, SOCK_STREAM, 0);
	if (r_socket==-1)
		{
		perror ("error creando socket");
		return 0;
		}


r_bind=bind(r_socket, (struct sockaddr *)&nos, sizeof(struct sockaddr)); 	
  if (r_bind==-1)
    {
    perror ("error en bind");
		return 0;
    }

srand(time(NULL)); //cambio la semilla del random
pid_padre=getpid(); //pid del proceso padre


signal (SIGUSR1, notifica_on);
signal (SIGUSR2, retalos);
signal (SIGALRM,alarma);
signal (SIGCHLD, muere_hijo);
signal (SIGTRAP, dile_sorteo);
signal (SIGXCPU, tirada);
signal (SIGILL, fin_partida);
signal (SIGPIPE, salida_forzosa);
//signal (SIGHUP,);
//signal (SIGSEGV,);	

for (;;)
{

r_listen=listen (r_socket,10);
  if (r_listen==-1)
    {
    perror ("Error en listen");
		return 0;
    }

printf ("Listen en marcha\n");

m=conecta(r_socket);
	  if (m==-1)
		{
		perror ("Error en accept");
		return 0;
		}


pid=fork();
if (pid==0)
{

printf ("r_accept del FORK = %d\n",m);
pid_hijo=getpid();//coges el pid del proceso hijo

while ((r=read(m,buff,2))>0)
{
alarm (60);
if (strncmp(buff,"01",2)==0)
{

s=comprueba_usuario(m);
  
  if(s==-2)
	{
	write(1,"\nEl usuario esta ON\n",20);
	num_pipe=m;
  write(m,"01El usuario esta ON",20);
	}
	if (s==-1) //el usuario no esta en la base de datos
  {
	write(1,"Usuario no encontrado\n",22);
  num_pipe=m;
  write(m,"01Login Incorrecto",18);
	}
	if (s>=0)
	{
	//el usuario esta en lista y nos devuelve la posicion del lseek
	write(1,"Usuario encontrado\n",19);
  num_pipe=m;
  write(m,"01Login Completado",18);
	}
}

if (strncmp(buff,"02",2)==0)
{

s=registrar_usuario(m);
	
	if(s==-1)
	{
	write(1,"\nEl usuario ya existe\n",22);
	num_pipe=m;
  write(m,"02El usuario ya existe",22);
	}
	if(s==0)
	{
	write(1,"\nRegistro completado\n",21);
	num_pipe=m;
  write(m,"02Registro completado",21);
	}
}
if (strncmp(buff,"03",2)==0)
{
dame_conectados(m);
	write(1,"Devuelve conectados\n",21);
}

if (strncmp(buff,"04",2)==0)
{
read(m,usuario2,12);
usuario2[12]='\0';
s=reta();
	if(s==-2)
	{
	write(1,"Usuario no conectado\n",21);
	num_pipe=m;
  write(m,"04El usuario se ha desconectado",31);
	}
  if(s==-1)
	{
	write(1,"Ya hay un reto\n",15);
	num_pipe=m;
  write(m,"04Ya hay un reto",16);
	}
	if(s==0)
	{
	write(1,"Reto lanzado\n",13);
	}

}

if (strncmp(buff,"05",2)==0)
{

  read(m,buff,35);
      for (i=0;i<12;i++)
      {
      usuario2[i]=buff[i+10];
      }
      usuario2[12]='\0';
      strncpy(tmp,usuario,12);
      tmp[12]='\0';

  if (strncmp(buff,"Rechazado ",10)==0)
  {
  write(1,"Rechazas el reto de ",20);
  write(1,usuario2,12);
  write(1,"\n",1);
  
     
  s=rechaza(tmp);
    
    if (s==-1)
    {
    write(1,"Error: No hay partida para borrar\n",34);
    close (fl);
    unlink(lock);//final de lock
    }
    if (s>=0)
    {
      fl= open("tmp.txt.lock",O_EXCL|O_CREAT,0777);
      while (fl==-1)
        {
        perror("Error Open. El archivo de entrada esta bloqueado\n");
        sleep(1);
        fl= open("tmp.txt.lock",O_EXCL|O_CREAT,0777);
        }
      fl= open("tmp.txt",O_RDWR|O_CREAT,0777);
      write(fl,usuario2,12);
      write(fl,"r",1);
      write(fl,usuario,12);
    
    kill (pid_padre, SIGUSR1);
    //s=lseek(r_partidas,s,SEEK_SET); 23 enero
    write(r_partidas,"                         ",25);
    write(1,"Partida borrada\n",16);
    close (fl);
    unlink(lock);//final de lock
    }
  }//final de rechazado

  if (strncmp(buff,"Aceptado  ",10)==0)
  {
      write(1,"Aceptas el reto de ",19);
      write(1,usuario2,12);
      write(1,"\n",1);
    

 if (busca_conectado(usuario2)==0)
 {
  sprintf(buff,"05El reto ha sido cancelado por desconexion de %s",usuario2);
  num_pipe=m;
  write(m,buff,strlen(buff)); 
 }    
 else
 {
    fl= open("partidas.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("partidas.txt.lock",O_EXCL|O_CREAT,0777);
    }
    //final de lock 
    
    sprintf(buff,"%sR%s",usuario2,usuario);
    lseek(r_partidas,0,SEEK_SET);
    while((read(r_partidas,buscando,25)>0))
     {
         if ((strncmp(buscando,buff,25))==0)
         {
         lseek(r_partidas,-13,SEEK_CUR);
         write(r_partidas," ",1);
         }
         lseek(r_partidas,+1,SEEK_CUR);
     }


    unlink("partidas.txt.lock");      
      

          fl= open("tmp.txt.lock",O_EXCL|O_CREAT,0777);
          while (fl==-1)
            {
              perror("Error Open. El archivo de entrada esta bloqueado\n");
              sleep(1);
              fl= open("tmp.txt.lock",O_EXCL|O_CREAT,0777);
            }
            fl= open("tmp.txt",O_RDWR|O_CREAT,0777);
            write(fl,usuario2,12);
            write(fl,"a",1);
            write(fl,usuario,12);
            kill (pid_padre, SIGUSR1);
 //Archivo de bloqueo
          fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
          while (fl==-1)
          {
          perror("Error Open. El archivo de entrada esta bloqueado\n");
          sleep(1);
          fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
          }
 
      s=suma_partida(usuario);
      if (s==0)
      {
      s=suma_partida(usuario2);
      }
    
    sorteo(usuario2);        
  }//final de else comprueba_conectados
  }//final de aceptado 
}//final de 05 (Reta)

if (strncmp(buff,"07",2)==0) //tirada
{
read(m,buff,13);
    
    fl= open("tirada.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("tirada.txt.lock",O_EXCL|O_CREAT,0777);
    }
    
lseek(r_tirada,0,SEEK_SET);
buff[13]='\0';
write(r_tirada,buff,13);

//write(1,buff,13);
//write(1,"\n",1);

fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
  while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    }

lseek(r_conectados,0,SEEK_SET);

while((read(r_conectados,lock,12))>0)
{
lock[12]='\0';
  if ((strncmp(buff,lock,12))==0)
    {
    lseek(r_conectados,+4,SEEK_CUR);
    read(r_conectados,&s,4);
    }
lseek(r_conectados,+13,SEEK_CUR);
}
lseek(r_tirada,0,SEEK_SET);
strncpy(buff,usuario,12);
buff[13]='\0';
write (1,"Usuario tira en columna ->",26);
write(1,buff,13);
write(r_tirada,buff,13);
write(1,"\n",1);


unlink ("conectados.txt.lock");
kill(s,SIGXCPU);

}

if (strncmp(buff,"08",2)==0) //4en raya, tablas...
{
char dos[3],us2[13];

read(m,buff,14);
    
    fl= open("tirada.txt.lock",O_EXCL|O_CREAT,0777);
    while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("tirada.txt.lock",O_EXCL|O_CREAT,0777);
    }
    
lseek(r_tirada,0,SEEK_SET);
buff[14]='\0';
write(r_tirada,buff,14);
write(1,buff,14);
write(1,"\n",1);
lseek(r_tirada,12,SEEK_SET);
read(r_tirada,dos,2);
dos[2]='\0';

fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
  while (fl==-1)
    {
    perror("Error Open. El archivo de entrada esta bloqueado\n");
    sleep(1);
    fl= open("conectados.txt.lock",O_EXCL|O_CREAT,0777);
    }

lseek(r_conectados,0,SEEK_SET);

while((read(r_conectados,lock,12))>0)
{
  if ((strncmp(buff,lock,12))==0)
    {
    read(r_conectados,&s,4);
    strncpy(us2,lock,12);
    us2[12]='\0';
    }
lseek(r_conectados,+13,SEEK_CUR);
}
unlink ("conectados.txt.lock");

lseek(r_tirada,0,SEEK_SET);
write(r_tirada,&s,4);
sprintf(buff,"%s%s%s",usuario,us2,dos);
write(r_tirada,buff,26);
kill(pid_padre,SIGILL);

}


cont=0;
alarm (60);
} //final de while
close(m);
write(1,"El FORK va a terminar\n\n\n\n",25);
exit(2);
}//final de fork	
}//este es el de final de for (;;)


return 0;
}
