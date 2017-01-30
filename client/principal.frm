VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.ocx"
Begin VB.Form principal 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Conecta4 - Desconectado"
   ClientHeight    =   5205
   ClientLeft      =   3240
   ClientTop       =   3510
   ClientWidth     =   8175
   Icon            =   "principal.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MouseIcon       =   "principal.frx":0ECA
   ScaleHeight     =   5205
   ScaleWidth      =   8175
   StartUpPosition =   2  'CenterScreen
   Begin MSWinsockLib.Winsock sock 
      Left            =   6720
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemoteHost      =   "shiva.upc.es"
      RemotePort      =   50412
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   380
      Left            =   7680
      Top             =   120
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   7200
      Top             =   120
   End
   Begin VB.ListBox listUsers 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4865
      IntegralHeight  =   0   'False
      ItemData        =   "principal.frx":264C
      Left            =   4920
      List            =   "principal.frx":264E
      TabIndex        =   11
      ToolTipText     =   "Haz doble click para retar"
      Top             =   180
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   6120
      TabIndex        =   3
      Top             =   6360
      Width           =   615
   End
   Begin VB.Frame frTexto 
      BackColor       =   &H00000000&
      Caption         =   "Notificaciones"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   2175
      Left            =   120
      TabIndex        =   1
      Top             =   2880
      Width           =   4575
      Begin VB.TextBox txtNotas 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1575
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   2
         Top             =   280
         Width           =   4215
      End
   End
   Begin VB.Frame frDetalles 
      BackColor       =   &H00000000&
      Caption         =   "Detalles Usuario"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   2655
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4575
      Begin VB.Frame FrEstado 
         BackColor       =   &H00000000&
         Caption         =   "Estado"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   1335
         Left            =   360
         TabIndex        =   4
         Top             =   720
         Width           =   3135
         Begin VB.Label txtEstado 
            BackStyle       =   0  'Transparent
            ForeColor       =   &H000000FF&
            Height          =   255
            Left            =   1680
            TabIndex        =   8
            Top             =   720
            Width           =   1215
         End
         Begin VB.Label txtConexion 
            BackStyle       =   0  'Transparent
            ForeColor       =   &H000000FF&
            Height          =   255
            Left            =   1680
            TabIndex        =   7
            Top             =   360
            Width           =   1215
         End
         Begin VB.Label Label5 
            BackStyle       =   0  'Transparent
            Caption         =   "Estado:"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   255
            Left            =   240
            TabIndex        =   6
            Top             =   720
            Width           =   1335
         End
         Begin VB.Label Label4 
            BackStyle       =   0  'Transparent
            Caption         =   "Conexión:"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   255
            Left            =   240
            TabIndex        =   5
            Top             =   360
            Width           =   975
         End
      End
      Begin VB.Label txtNick 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   1200
         TabIndex        =   10
         Top             =   380
         Width           =   2295
      End
      Begin VB.Label Label7 
         BackStyle       =   0  'Transparent
         Caption         =   "Nick:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   480
         TabIndex        =   9
         Top             =   380
         Width           =   495
      End
   End
   Begin VB.Menu inicio 
      Caption         =   "Inicio Sesión"
   End
   Begin VB.Menu usuarios 
      Caption         =   "Consulta Usuarios"
   End
   Begin VB.Menu salir 
      Caption         =   "Salir"
   End
   Begin VB.Menu acerca 
      Caption         =   "Acerca de..."
      Index           =   1
   End
End
Attribute VB_Name = "principal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public St As String
Public St2 As String
Public St3 As String
Public St4 As String
Public St5 As String
Public conectado As Boolean
Public oponente, oponente_valido As String 'he quitado contrincante
Public WNameVentana As String

Private Sub acerca_Click(Index As Integer)
msgacerca = True
MsgBox vbCrLf & "Sergio Garcia" & vbCrLf & "Javier Schapira" & vbCrLf & "Jose Puig" & vbCrLf & "Karina Reynoso" & vbCrLf & "Raquel Arellano" & vbCrLf & vbCrLf & "Proyecto SO hecho en 2008", vbInformation, "About..."
msgacerca = False
'creditos.Show
End Sub

Private Sub Command1_Click()
Form1.Show
End Sub

Private Sub Command2_Click()
Text1.Text = nick
End Sub

Private Sub Command3_Click()
Dim nuevoform As New Tablero
nuevoform.Show
nuevoform.txtEstado = "Prueba2"
End Sub



Private Sub Form_Load()
msgacerca = False
msgtab = False
msgprincipal = False
contareto = 0

listUsers.AddItem "Lista de Usuarios"
sock.Connect
txtConexion.Caption = "No conectado"
txtEstado.Caption = "No conectado"
usuarios.Enabled = False
inicio.Enabled = True
principal.Enabled = False
Timer1.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
Dim respuesta As Integer
Dim cabe, cabe2 As String


If sock.State <> sckConnected Then
    msgprincipal = True
    respuesta = MsgBox("¿Desea salir de la aplicación?", vbYesNo + vbInformation, "Salir")
    If respuesta = vbYes Then
        msgprincipal = False
        Timer2.Enabled = True
    Else
        msgprincipal = False
        Cancel = True
    End If
Else 'estas conectado
    msgprincipal = True
    respuesta = MsgBox("¿Desea salir de la aplicación?", vbYesNo + vbInformation + vbApplicationModal, "Salir")
    If respuesta = vbYes Then
        msgprincipal = False
        Dim fm As Form
            For Each fm In Forms
                cabe = fm.Caption
                cabe2 = Mid(cabe, 1, 14)
                'MsgBox cabe2
                If cabe2 = "Jugando contra" Then
                    MsgBox "Antes de salir debes terminar tus partidas", vbCritical, "Tienes partidas activas"
                    Cancel = True
                    Exit Sub
                    End If
                Next fm
            hora = "[" & Time & "] "
            txtNotas.Text = txtNotas.Text & hora & "Desconectado!" & vbCrLf
            sock.Close
            WNameVentana = "Tablero"
            CerrarSiVentanaAbierta
            WNameVentana = "creditos"
            CerrarSiVentanaAbierta
            WNameVentana = "msg"
            CerrarSiVentanaAbierta
            Timer2.Enabled = True
            
    Else 'vbNO
        msgprincipal = False
        Cancel = True
    End If
End If
msgprincipal = False

End Sub

Private Sub inicio_Click()
Login.Show 1
End Sub

Private Sub Label8_Click()

End Sub

Private Sub listUsers_DblClick()
If listUsers.Text = "Lista de Usuarios" Then
Exit Sub
End If

Dim usuario As String
principal.Enabled = False
Timer1.Enabled = True
usuario = Mid(listUsers.Text, 1, 12)


If nick = usuario Then
    txtNotas.Text = txtNotas.Text & hora & "No te puedes retar a ti mismo" & vbCrLf
Else
    hora = "[" & Time & "]"
    txtNotas.Text = txtNotas.Text & hora & "Has retado a " & usuario & vbCrLf
    sock.SendData "04" & usuario
End If

End Sub

Private Sub partida_Click()

End Sub

Private Sub salir_Click()
Dim respuesta As Integer
Dim cabe, cabe2 As String

If sock.State <> sckConnected Then
    msgprincipal = True
    respuesta = MsgBox("¿Desea salir de la aplicación?", vbYesNo + vbInformation, "Salir")
    If respuesta = vbYes Then
        msgprincipal = False
        Timer2.Enabled = True
    Else
        msgprincipal = False
        Cancel = True
    End If
Else 'estas conectado
'If msgprincipal = True Or msgtab = True Or msgacerca = True Or contareto > 0 Then
'txtNotas.Text = txtNotas.Text & hora & "Imposible cerrar, tienes avisos pendientes"
'Exit Sub
'Else
    msgprincipal = True
    respuesta = MsgBox("¿Desea salir de la aplicación?", vbYesNo + vbInformation, "Salir")
    If respuesta = vbYes Then
    msgprincipal = False
        Dim fm As Form
            For Each fm In Forms
                cabe = fm.Caption
                cabe2 = Mid(cabe, 1, 14)
                'MsgBox cabe2
                If cabe2 = "Jugando contra" Then
                    txtNotas.Text = txtNotas.Text & hora & "Termina tus partidas antes de cerrar" & vbCrLf
                    Cancel = True
                    Exit Sub
                    End If
            Next fm
            
            hora = "[" & Time & "] "
            txtNotas.Text = txtNotas.Text & hora & "Desconectado!" & vbCrLf
            sock.Close
            WNameVentana = "Tablero"
            CerrarSiVentanaAbierta
            WNameVentana = "about"
            CerrarSiVentanaAbierta
            WNameVentana = "msg"
            CerrarSiVentanaAbierta
            Timer2.Enabled = True
            
    Else 'vbNO
        msgprincipal = False
        Cancel = True
    End If

'End If
End If
msgprincipal = False
End Sub


Private Sub sock_Close()
    desconectado = True
    txtConexion.ForeColor = &HFF&
    txtEstado.ForeColor = &HFF&
    txtConexion.Caption = "No conectado"
    txtEstado.Caption = "No conectado"
    usuarios.Enabled = False
    inicio.Enabled = False
    listUsers.Clear
    listUsers.AddItem "Lista de usuarios"
    txtNotas.Text = txtNotas.Text & hora & "Has sido desconectado por el servidor" & vbCrLf
    txtNick.Caption = ""
    Me.Caption = "Conecta4 - Desconectado"
    listUsers.Enabled = False
            Dim formulario As Form
            For Each formulario In Forms
                    sal = formulario.Caption
                    sal2 = Mid(sal, 1, 7)
                        If sal2 = "Jugando" Then
                        formulario.Caption = "Partida terminada"
                        formulario.txtEstado.Caption = "Has perdido por desconexion"
                        formulario.sudoku.Enabled = False
                        formulario.gana = True
                        formulario.turno = False
                        End If
            Next formulario
     MsgBox "Has sido desconectado por el servidor", vbCritical, "Desconexión efectuada..."
     Exit Sub
End Sub

Private Sub sock_Connect()
hora = "[" & Time & "]"
txtNotas.Text = hora & "Esperando Inicio de Sesión" & vbCrLf
End Sub

Private Sub sock_DataArrival(ByVal bytesTotal As Long)
Dim sal, sal2 As String

sock.GetData St
hora = "[" & Time & "]"

St2 = Mid(St, 1, 2)
'St3 = Mid(St, 3, Len(St))

If St2 = "99" Then
St3 = Mid(St, 3, Len(St))
txtNotas.Text = txtNotas.Text & hora & St3 & vbCrLf
End If


If St2 = "01" Then
St3 = Mid(St, 3, Len(St))

If St3 = "El usuario esta ON" Then
MsgBox St3, vbExclamation, "Imposible conectar"
Login.Command1.Value = 1
txtNotas.Text = txtNotas.Text & hora & "ERROR: Usuario actualmente conectado" & vbCrLf
End If

If St3 = "Login Completado" Then
txtNotas.Text = txtNotas.Text & hora & "Conexion establecida con éxito" & vbCrLf
MsgBox St3, vbInformation, "Validacion correcta"
nick = Login.txtLogin.Text
principal.txtConexion.ForeColor = &HFF00&
principal.txtEstado.ForeColor = &HFF00&
principal.txtConexion.Caption = "Conectado"
principal.txtEstado.Caption = "Esperando"
principal.inicio.Enabled = False
principal.usuarios.Enabled = True
principal.txtNick.Caption = nick
principal.Caption = "Conecta4 - Jugando como " & nick
Unload Login
End If

If St3 = "Login Incorrecto" Then
MsgBox St3, vbCritical, "Validación erronea"
Login.Command1.Value = 1
txtNotas.Text = txtNotas.Text & hora & "ERROR: Login Incorrecto" & vbCrLf
End If

End If 'final de if de st2=01 -> login



If St2 = "02" Then
St3 = Mid(St, 3, Len(St))

If St3 = "Registro completado" Then
MsgBox St3 & vbCrLf & "Ahora serás logueado automaticamente", vbInformation, "Registro"
nick = Login.txtLogin.Text
txtNotas.Text = txtNotas.Text & hora & "Conexion establecida con éxito" & vbCrLf
principal.txtConexion.ForeColor = &HFF00&
principal.txtEstado.ForeColor = &HFF00&
principal.txtConexion.Caption = "Conectado"
principal.txtEstado.Caption = "Esperando"
principal.inicio.Enabled = False
principal.usuarios.Enabled = True
principal.txtNick.Caption = nick
principal.Caption = "Conecta4 - Jugando como " & nick
Unload Login
End If

If St3 = "El usuario ya existe" Then
Login.Command1.Value = 1
MsgBox St3, vbCritical, "Registro"
End If

End If

If St2 = "03" Then
For i = 1 To (bytesTotal + 2) / 16
St3 = Mid(St, 3 + (16 * (i - 1)), 12)
St4 = Mid(St, 15 + (16 * (i - 1)), 2)

Dim num As Integer
num = 1 * St4
If num = 0 Then
listUsers.AddItem St3 & vbTab & "- No Juega -" & vbTab & (num)
End If
If num < 10 And St4 <> 0 Then
listUsers.AddItem St3 & vbTab & "- Jugando -" & vbTab & (num)
End If
If num > 9 Then
listUsers.AddItem St3 & vbTab & "- Jugando -" & vbTab & (num)
End If

Next i 'final de for


End If 'final de st="03"


If St2 = "04" Then 'reta
St3 = Mid(St, 3, 7)
  If St3 = "Te Reta" Then
    'contareto = contareto + 1
    St3 = Mid(St, 3, 20)
    St4 = Mid(St, 11, 12)
    oponente = St4
    txtNotas.Text = txtNotas.Text & hora & "Te ha retado " & oponente & vbCrLf
    If msgprincipal = True Or msgtab = True Or msgacerca = True Then
        txtNotas.Text = txtNotas.Text & hora & "Rechazado automaticamente el reto de " & oponente & vbCrLf
        txtNotas.Text = txtNotas.Text & hora & "Tienes otros avisos activos, cierralos primero" & vbCrLf
        sock.SendData "05Rechazado " & oponente & " " & nick
        Exit Sub
    Else
        Dim msform As New msg
        msform.Show
        msform.rival = oponente
        msform.Label1.Caption = St3 & vbCrLf & "¿Quieres aceptar el reto?"
    
    End If
    
    'If contareto = 1 Then
          'oponente_valido = oponente
          'Dim respuesta As Integer
          'respuesta = MsgBox(St3 & vbCrLf & "¿Quieres aceptar el reto?", vbYesNo + vbInformation, "Has sido retado!")
          'If respuesta = vbYes Then
                'If msgprincipal = True Or msgtab = True Or msgacerca = True Then
                    'contareto = contareto - 1
                    'txtNotas.Text = txtNotas.Text & hora & "Rechazado automaticamente el reto de " & oponente_valido & vbCrLf
                    'txtNotas.Text = txtNotas.Text & hora & "Tienes otros avisos activos, cierralos primero" & vbCrLf
                    'sock.SendData "05Rechazado " & oponente_valido & " " & nick
                    'Exit Sub
                'Else
                  '  contareto = contareto - 1
                  '  txtNotas.Text = txtNotas.Text & hora & "Has aceptado el reto de " & oponente_valido & vbCrLf
                  '  sock.SendData "05Aceptado  " & oponente_valido & " " & nick
                'End If
            
          'Else 'dice que no directamente
          'contareto = contareto - 1
          'txtNotas.Text = txtNotas.Text & hora & "Has rechazado el reto de " & oponente_valido & vbCrLf
          'sock.SendData "05Rechazado " & oponente_valido & " " & nick
          'End If
    'Else
      '  contareto = contareto - 1
      '  txtNotas.Text = txtNotas.Text & hora & "Rechazado automaticamente el reto de " & oponente & vbCrLf
      '  txtNotas.Text = txtNotas.Text & hora & "Solo puedes tener una invitacion de reto" & vbCrLf
      '  sock.SendData "05Rechazado " & oponente & " " & nick
    'End If 'contareto
  End If 'aqui se acaba el reto optimo
  
  If St3 = "Ya hay " Then
    St3 = Mid(St, 3, 14)
    txtNotas.Text = txtNotas.Text & hora & St3 & " pendiente entre estos jugadores o ya estan jugando una partida" & vbCrLf
  End If
    
    If St3 = "El usua" Then
    St3 = Mid(St, 3, 29)
    txtNotas.Text = txtNotas.Text & hora & St3 & vbCrLf
  End If
End If 'termina 04


If St2 = "05" Then
St3 = Mid(St, 3, 1)
    If St3 = "E" Then
    St3 = Mid(St, 3, 57)
    txtNotas.Text = txtNotas.Text & hora & St3 & vbCrLf
    End If
    If St3 = "r" Then
    St3 = Mid(St, 5, 12)
    txtNotas.Text = txtNotas.Text & hora & "Tu reto ha sido rechazado por " & St3 & vbCrLf
    End If
    If St3 = "a" Then
    St3 = Mid(St, 5, 12)
    txtNotas.Text = txtNotas.Text & hora & "Tu reto ha sido aceptado por " & St3 & vbCrLf
    End If
End If


If St2 = "06" Then 'resultado del sorteo
St3 = Mid(St, 3, 12)
St4 = Mid(St, 15, 12)
Dim nuevoform As New Tablero
    If nick = St3 Then 'yo saco
    nuevoform.Show
    nuevoform.txtEstado.Caption = "Te toca"
    nuevoform.Caption = "Jugando contra " & St4
    nuevoform.sudoku.Enabled = True
    nuevoform.saca = True
    nuevoform.turno = True
    nuevoform.rival = St4
    nuevoform.roj.Visible = True
    'nuevoform.SetFocus
    End If
    If nick = St4 Then 'él saca
    nuevoform.Show
    nuevoform.txtEstado.Caption = "Turno de tu oponente"
    nuevoform.Caption = "Jugando contra " & St3
    nuevoform.sudoku.Enabled = False
    nuevoform.saca = False
    nuevoform.turno = False
    nuevoform.rival = St3
    nuevoform.verd.Visible = True
    'nuevoform.SetFocus
    End If
    If nick <> St3 And nick <> St4 Then
    St3 = Mid(St, 3, Len(St))
    txtNotas.Text = txtNotas.Text & hora & "Error recibiendo datos 06-sorteo->" & St3 & vbCrLf
    End If

End If 'final de 06 sorteo y crea tablero

If St2 = "07" Then 'tirada
St3 = Mid(St, 3, 12)
St4 = Mid(St, 15, 1)

Dim frm As Form
    For Each frm In Forms
        If frm.Caption = ("Jugando contra " & St3) Then
            frm.sudoku.Enabled = True
            frm.sudoku.Col = St4
            frm.Command1.Value = True
            frm.txtEstado.Caption = "Te toca"
            'frm.SetFocus
            Exit Sub
        End If
    Next frm

End If '07

If St2 = "08" Then

St3 = Mid(St, 3, 12)
St4 = Mid(St, 15, 1)
St5 = Mid(St, 16, 1)

    
    For Each frm In Forms
        If frm.Caption = ("Jugando contra " & St3) Then
                If St5 = "T" Then
                frm.txtEstado.Caption = "La partida acaba en tablas!"
                frm.sudoku.Col = St4
                frm.Command1.Value = True
                End If
                If St5 = "R" Then
                frm.txtEstado.Caption = "Has ganado por retiro!"
                End If
                If St5 = "A" Then
                frm.txtEstado.Caption = "Has ganado por timeout rival!"
                End If
                If St5 = "P" Then
                frm.sudoku.Col = St4
                frm.Command1.Value = True
                frm.txtEstado.Caption = "4 en raya! Te han ganado!"
                End If
            frm.sudoku.Enabled = False
            frm.turno = False
            frm.ganador.Enabled = True
            frm.gana = True
            frm.revisa
            frm.Caption = "Partida terminada"
            'frm.SetFocus
            Exit Sub
        End If
    Next frm
End If '08

End Sub

Private Sub Timer1_Timer()
Timer1.Enabled = False
Dim respuesta As Integer

If sock.State <> sckConnected Then
sock.Close
respuesta = MsgBox("El servidor está desconectado" & vbCrLf & "Conecta el servidor y reintenta", vbCritical + vbRetryCancel, "Error conectando...")
    If respuesta = vbRetry Then
    sock.Connect
    Timer1.Enabled = True
    Else
    MsgBox "Tendrás que reiniciar el programa para poder conectar más adelante", vbInformation, "Error"
    End
    End If
Else
principal.Enabled = True
desconectado = False

End If
End Sub

Private Sub Timer2_Timer()
End
End Sub


Private Sub txtNotas_Change()
txtNotas.SelStart = Len(txtNotas.Text)
End Sub

Private Sub usuarios_Click()
principal.Enabled = False
Timer1.Enabled = True
sock.SendData "03"
listUsers.Clear
listUsers.AddItem "Lista de Usuarios"
End Sub

Sub CerrarSiVentanaAbierta()
   Dim frmElement As Form
      WSiExiste = False
      For Each frmElement In Forms
          If frmElement.Name = WNameVentana Then
             frmElement.SetFocus
             Unload frmElement
          End If
      Next frmElement
End Sub

