VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form Tablero 
   Appearance      =   0  'Flat
   BackColor       =   &H00000000&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Tablero de Juego "
   ClientHeight    =   3600
   ClientLeft      =   2640
   ClientTop       =   3495
   ClientWidth     =   3285
   ClipControls    =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "Tablero.frx":0000
   ScaleHeight     =   3600
   ScaleWidth      =   3285
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox roj 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   360
      Picture         =   "Tablero.frx":08CA
      ScaleHeight     =   375
      ScaleWidth      =   375
      TabIndex        =   7
      Top             =   3120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox verd 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   360
      Picture         =   "Tablero.frx":4399
      ScaleHeight     =   375
      ScaleWidth      =   375
      TabIndex        =   6
      Top             =   3120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "click"
      Height          =   315
      Left            =   2280
      TabIndex        =   5
      Top             =   2040
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Timer ganador 
      Enabled         =   0   'False
      Interval        =   300
      Left            =   1320
      Top             =   1920
   End
   Begin VB.PictureBox nada 
      Height          =   375
      Left            =   1320
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   4
      Top             =   3960
      Width           =   375
   End
   Begin VB.PictureBox verde 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   720
      Picture         =   "Tablero.frx":7F36
      ScaleHeight     =   375
      ScaleWidth      =   375
      TabIndex        =   3
      Top             =   3840
      Width           =   375
   End
   Begin VB.PictureBox rojo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   240
      Picture         =   "Tablero.frx":BB07
      ScaleHeight     =   375
      ScaleWidth      =   375
      TabIndex        =   2
      Top             =   3840
      Width           =   375
   End
   Begin MSFlexGridLib.MSFlexGrid sudoku 
      Height          =   2870
      Left            =   240
      TabIndex        =   1
      ToolTipText     =   "Haz click en la columna de tiro"
      Top             =   120
      Width           =   2870
      _ExtentX        =   5054
      _ExtentY        =   5054
      _Version        =   393216
      Rows            =   7
      Cols            =   7
      FixedRows       =   0
      FixedCols       =   0
      FocusRect       =   0
      HighLight       =   0
      ScrollBars      =   0
      PictureType     =   1
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "Tablero.frx":F6AD
      OLEDropMode     =   1
   End
   Begin VB.Label txtEstado 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   180
      Left            =   960
      TabIndex        =   0
      Top             =   3240
      Width           =   45
   End
End
Attribute VB_Name = "Tablero"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public row1, col1, row2, col2, row3, col3, row4, col4 As Integer
Public rival As String
Public sal, perdedor, gana, valor, pintado, saca, turno, cerrar As Boolean
Public win, comprobar As String
Public filaWin, colWin, veces As Integer

Public Function revisa()
Dim cont, cont2, i, k, j As Integer
perdedor = True
cont2 = 0
cont = 0

'DIAGONAL1
sudoku.ColSel = sudoku.Col
sudoku.RowSel = sudoku.Row
cont = 0
For k = 3 To 6
For j = k To 0 Step -1
For i = 0 To k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                    End If
        Else
            cont = 0
        End If
j = j - 1
Next i
Next j
cont = 0
Next k

cont = 0
For k = 1 To 3
For j = 6 To k Step -1
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont = 0
        End If
j = j - 1
Next i
Next j
cont = 0
Next k


'DIAGONAL2
cont = 0
For k = 0 To 3
For j = k To 6
For i = 0 To 6 - k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont = 0
        End If
j = j + 1
Next i
Next j
cont = 0
Next k


cont = 0
For k = 1 To 3
For j = 0 To 6 - k
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont = 0
        End If
j = j + 1
Next i
Next j
cont = 0
Next k

'HORIZONTAL
cont = 0
For j = 0 To 6
sudoku.Row = j
For i = 0 To 6
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 4 Then
                gana = True
                win = "H"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                ganador.Enabled = True
                Exit Function
                End If
        Else
            cont = 0
        End If

Next i
cont = 0
Next j


'VERTICAL
cont = 0
For j = 0 To 6
sudoku.Col = j
For i = 0 To 6
sudoku.Row = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 4 Then
                gana = True
                win = "V"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                ganador.Enabled = True
                Exit Function
                End If
        Else
            cont = 0
        End If
Next i
cont = 0
Next j


'empiezan las comprobaciones de 4 en raya verde

'DIAGONAL1
cont2 = 0
sudoku.ColSel = sudoku.Col
sudoku.RowSel = sudoku.Row
For k = 3 To 6
For j = k To 0 Step -1
For i = 0 To k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont2 = 0
        End If
j = j - 1
Next i
Next j
cont2 = 0
Next k

cont2 = 0
For k = 1 To 3
For j = 6 To k Step -1
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont2 = 0
        End If
j = j - 1
Next i
Next j
cont2 = 0
Next k


'DIAGONAL2
cont2 = 0
For k = 0 To 3
For j = k To 6
For i = 0 To 6 - k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont2 = 0
        End If
j = j + 1
Next i
Next j
cont2 = 0
Next k

cont2 = 0
For k = 1 To 3
For j = 0 To 6 - k
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    ganador.Enabled = True
                    Exit Function
                End If
        Else
            cont2 = 0
        End If
j = j + 1
Next i
Next j
cont2 = 0
Next k

'HORIZONTAL
cont2 = 0
For j = 0 To 6
sudoku.Row = j
For i = 0 To 6
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 4 Then
                gana = True
                win = "H"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                ganador.Enabled = True
                Exit Function
                End If
        Else
            cont2 = 0
        End If
Next i
cont2 = 0
Next j


'VERTICAL
cont2 = 0
For j = 0 To 6
sudoku.Col = j
For i = 0 To 6
sudoku.Row = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 4 Then
                gana = True
                win = "V"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                ganador.Enabled = True
                Exit Function
                End If
        Else
            cont2 = 0
        End If
Next i
cont2 = 0
Next j



End Function
Private Sub Command1_Click()
sudoku_Click
End Sub

Private Sub Form_Load()
perdedor = False
win = False
pintado = True
veces = 0
cerrar = False


' declarem una variable entera
Dim i, x, y As Long


' Define la altura y anchura de cada celda
For i = 0 To sudoku.Rows - 1
        sudoku.RowHeight(i) = 410
Next
For i = 0 To sudoku.Cols - 1
        sudoku.ColWidth(i) = 410
Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Me.Caption <> "Partida terminada" Then
        Dim respuesta As Integer
        msgtab = True
        respuesta = MsgBox("¿Abandonar partida? Perderá por abandono..", vbYesNo + vbExclamation, "Salir")
        If respuesta = vbYes Then
            msgtab = False
            If gana = False Then
            principal.sock.SendData ("08" & rival & "0" & "R")
            End If
            Unload Me
        Else
            msgtab = False
            Cancel = True
        End If
    
    Else
    msgtab = False
    Unload Me
    End If
msgtab = False
End Sub

Private Sub ganador_Timer()
Dim fila, columna, i As Integer
Dim j As Double


gana = True

If perdedor = False Then
txtEstado.Caption = "Has ganado!"
End If


veces = veces + 1

If win = "V" Then
fila = filaWin
columna = colWin
    If pintado = True Then
        For i = fila To fila - 3 Step -1
            sudoku.Row = i
            Set sudoku.CellPicture = nada.Picture
        Next i
        pintado = False
    Else
        For i = fila To fila - 3 Step -1
            sudoku.Row = i
            If perdedor = False Then
                If saca = True Then
                Set sudoku.CellPicture = rojo.Picture
                Else
                Set sudoku.CellPicture = verde.Picture
                End If
            Else
                If saca = True Then
                Set sudoku.CellPicture = verde.Picture
                Else
                Set sudoku.CellPicture = rojo.Picture
                End If
            End If
        Next i
        pintado = True
    End If

ElseIf win = "H" Then
fila = filaWin
columna = colWin
    If pintado = True Then
        For i = columna To columna - 3 Step -1
            sudoku.Col = i
            Set sudoku.CellPicture = nada.Picture
        Next i
        pintado = False
    Else
        For i = columna To columna - 3 Step -1
            sudoku.Col = i
            If perdedor = False Then
                If saca = True Then
                Set sudoku.CellPicture = rojo.Picture
                Else
                Set sudoku.CellPicture = verde.Picture
                End If
            Else
                If saca = True Then
                Set sudoku.CellPicture = verde.Picture
                Else
                Set sudoku.CellPicture = rojo.Picture
                End If
            End If
        Next i
        pintado = True
    End If

ElseIf win = "D" Then
    If pintado = True Then
            sudoku.Col = col1
            sudoku.Row = row1
            Set sudoku.CellPicture = nada.Picture
            sudoku.Col = col2
            sudoku.Row = row2
            Set sudoku.CellPicture = nada.Picture
            sudoku.Col = col3
            sudoku.Row = row3
            Set sudoku.CellPicture = nada.Picture
            sudoku.Col = col4
            sudoku.Row = row4
            Set sudoku.CellPicture = nada.Picture
        pintado = False
    Else
            If perdedor = False Then
                If saca = True Then
                    sudoku.Col = col1
                    sudoku.Row = row1
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col2
                    sudoku.Row = row2
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col3
                    sudoku.Row = row3
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col4
                    sudoku.Row = row4
                    Set sudoku.CellPicture = rojo.Picture
                Else
                    sudoku.Col = col1
                    sudoku.Row = row1
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col2
                    sudoku.Row = row2
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col3
                    sudoku.Row = row3
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col4
                    sudoku.Row = row4
                    Set sudoku.CellPicture = verde.Picture
                End If
            Else
                If saca = True Then
                    sudoku.Col = col1
                    sudoku.Row = row1
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col2
                    sudoku.Row = row2
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col3
                    sudoku.Row = row3
                    Set sudoku.CellPicture = verde.Picture
                    sudoku.Col = col4
                    sudoku.Row = row4
                    Set sudoku.CellPicture = verde.Picture
                Else
                    sudoku.Col = col1
                    sudoku.Row = row1
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col2
                    sudoku.Row = row2
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col3
                    sudoku.Row = row3
                    Set sudoku.CellPicture = rojo.Picture
                    sudoku.Col = col4
                    sudoku.Row = row4
                    Set sudoku.CellPicture = rojo.Picture
                End If
            End If
        pintado = True
    End If
End If

If veces = 10 Then
    veces = 0
    ganador.Enabled = False
End If

End Sub

Private Sub sudoku_Click()
Dim i, j, k, cont, cont2, Fseleccionada, Cseleccionada As Integer
Dim Columna_envio As String

sudoku.Enabled = False
Cseleccionada = sudoku.ColSel
Fseleccionada = sudoku.RowSel


sudoku.Col = Cseleccionada
sudoku.Row = Fseleccionada
Columna_envio = Cseleccionada

cont = 0
cont2 = 0

'mira que no este completa la columna en la que hago click
sudoku.Row = 0
If sudoku.CellPicture <> 0 Then 'ahora no da mensaje
    'MsgBox "Columna completa", vbExclamation, "Movimiento erroneo"
    'completa.Show
    sudoku.Enabled = True
Exit Sub
Else 'tira normal


txtEstado.Caption = "Turno de tu oponente"

    For j = 0 To 6
        sudoku.Row = 6 - j
        If sudoku.CellPicture = 0 Then
                For i = 0 To sudoku.Row * 100000
                If (i Mod 100000 = 0) Then
                    sudoku.Row = i / 100000
                        If saca = True And turno = True Then
                            Set sudoku.CellPicture = rojo.Picture
                        End If
                        If saca = True And turno = False Then
                            Set sudoku.CellPicture = verde.Picture
                        End If
                        If saca = False And turno = True Then
                            Set sudoku.CellPicture = verde.Picture
                        End If
                        If saca = False And turno = False Then
                            Set sudoku.CellPicture = rojo.Picture
                        End If
                    If sudoku.Row > 0 Then
                        sudoku.Row = (i / 100000) - 1
                        Set sudoku.CellPicture = nada.Picture
                    End If
                    sudoku.CellAlignment = flexAlignCenterCenter
                End If
            Next i
        j = 6
        End If
    Next j
        
 
End If 'se acaba la comprobacion de que la columna no esta completa


'/////////////EMPIEZAN LAS COMPROBACIONES (verde+rojo)
'solo si es mi turno
'empiezan las comprobaciones de 4 en raya rojo
If turno = True Then




'DIAGONAL1
sudoku.ColSel = sudoku.Col
sudoku.RowSel = sudoku.Row
cont = 0
For k = 3 To 6
For j = k To 0 Step -1
For i = 0 To k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                    End If
        Else
            cont = 0
        End If
j = j - 1
Next i
Next j
cont = 0
Next k

cont = 0
For k = 1 To 3
For j = 6 To k Step -1
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont = 0
        End If
j = j - 1
Next i
Next j
cont = 0
Next k


'DIAGONAL2
cont = 0
For k = 0 To 3
For j = k To 6
For i = 0 To 6 - k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont = 0
        End If
j = j + 1
Next i
Next j
cont = 0
Next k


cont = 0
For k = 1 To 3
For j = 0 To 6 - k
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont = 0
        End If
j = j + 1
Next i
Next j
cont = 0
Next k

'HORIZONTAL
cont = 0
For j = 0 To 6
sudoku.Row = j
For i = 0 To 6
sudoku.Col = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 4 Then
                gana = True
                win = "H"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                principal.sock.SendData ("08" & rival & Columna_envio & "P")
                turno = False
                Me.Caption = "Partida terminada"
                ganador.Enabled = True
                Exit Sub
                End If
        Else
            cont = 0
        End If

Next i
cont = 0
Next j


'VERTICAL
cont = 0
For j = 0 To 6
sudoku.Col = j
For i = 0 To 6
sudoku.Row = i
        If sudoku.CellPicture = rojo.Picture Then
            cont = cont + 1
                If cont = 4 Then
                gana = True
                win = "V"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                principal.sock.SendData ("08" & rival & Columna_envio & "P")
                turno = False
                Me.Caption = "Partida terminada"
                ganador.Enabled = True
                Exit Sub
                End If
        Else
            cont = 0
        End If
Next i
cont = 0
Next j


'empiezan las comprobaciones de 4 en raya verde

'DIAGONAL1
cont2 = 0
sudoku.ColSel = sudoku.Col
sudoku.RowSel = sudoku.Row
For k = 3 To 6
For j = k To 0 Step -1
For i = 0 To k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont2 = 0
        End If
j = j - 1
Next i
Next j
cont2 = 0
Next k

cont2 = 0
For k = 1 To 3
For j = 6 To k Step -1
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont2 = 0
        End If
j = j - 1
Next i
Next j
cont2 = 0
Next k


'DIAGONAL2
cont2 = 0
For k = 0 To 3
For j = k To 6
For i = 0 To 6 - k
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont2 = 0
        End If
j = j + 1
Next i
Next j
cont2 = 0
Next k

cont2 = 0
For k = 1 To 3
For j = 0 To 6 - k
For i = k To 6
sudoku.Row = j
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 1 Then
                    row1 = sudoku.Row
                    col1 = sudoku.Col
                    End If
                If cont2 = 2 Then
                    row2 = sudoku.Row
                    col2 = sudoku.Col
                    End If
                If cont2 = 3 Then
                    row3 = sudoku.Row
                    col3 = sudoku.Col
                    End If
                If cont2 = 4 Then
                    row4 = sudoku.Row
                    col4 = sudoku.Col
                    gana = True
                    win = "D"
                    principal.sock.SendData ("08" & rival & Columna_envio & "P")
                    turno = False
                    Me.Caption = "Partida terminada"
                    ganador.Enabled = True
                    Exit Sub
                End If
        Else
            cont2 = 0
        End If
j = j + 1
Next i
Next j
cont2 = 0
Next k

'HORIZONTAL
cont2 = 0
For j = 0 To 6
sudoku.Row = j
For i = 0 To 6
sudoku.Col = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 4 Then
                gana = True
                win = "H"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                principal.sock.SendData ("08" & rival & Columna_envio & "P")
                turno = False
                Me.Caption = "Partida terminada"
                ganador.Enabled = True
                Exit Sub
                End If
        Else
            cont2 = 0
        End If
Next i
cont2 = 0
Next j


'VERTICAL
cont2 = 0
For j = 0 To 6
sudoku.Col = j
For i = 0 To 6
sudoku.Row = i
        If sudoku.CellPicture = verde.Picture Then
            cont2 = cont2 + 1
                If cont2 = 4 Then
                gana = True
                win = "V"
                filaWin = sudoku.Row
                colWin = sudoku.Col
                principal.sock.SendData ("08" & rival & Columna_envio & "P")
                turno = False
                Me.Caption = "Partida terminada"
                ganador.Enabled = True
                Exit Sub
                End If
        Else
            cont2 = 0
        End If
Next i
cont2 = 0
Next j

cont2 = 0
cont = 0
For i = 0 To 6
    sudoku.Row = 0
    sudoku.Col = i
        If sudoku.CellPicture <> 0 Then
        cont = cont + 1
            If cont = 7 Then
            'MsgBox "Tablero completo", vbCritical, "Tablas!"
            principal.sock.SendData ("08" & rival & Columna_envio & "T")
            txtEstado.Caption = "La partida acaba en tablas!"
            turno = False
            gana = True
            Me.Caption = "Partida terminada"
            Exit Sub
            End If
        End If
Next i

'Si llega aqui es que no ha habido:
'ni 4 en raya
'ni tablas
'ni columna completa


    If turno = True Then
    '///////////////////////////////////////////////////////
    'secuencia de envio de datos
    principal.sock.SendData ("07" & rival & Columna_envio)
    '///////////////////////////////////////////////////////
    End If


End If 'final de If turno = True Then

    
    If turno = True Then
        turno = False
        sudoku.Enabled = False
        Exit Sub
    End If
    If turno = False Then
        turno = True
        sudoku.Enabled = True
        Exit Sub
    End If

End Sub

