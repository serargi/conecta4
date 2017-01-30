VERSION 5.00
Begin VB.Form msg 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Has sido retado!"
   ClientHeight    =   1530
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3030
   ControlBox      =   0   'False
   Icon            =   "msg.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1530
   ScaleWidth      =   3030
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "No"
      Height          =   365
      Left            =   1560
      TabIndex        =   1
      Top             =   960
      Width           =   1140
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Sí"
      Default         =   -1  'True
      Height          =   365
      Left            =   240
      TabIndex        =   0
      Top             =   960
      Width           =   1140
   End
   Begin VB.Image Image1 
      Height          =   660
      Left            =   120
      Picture         =   "msg.frx":1782
      Top             =   120
      Width           =   615
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Label1"
      Height          =   195
      Left            =   1080
      TabIndex        =   2
      Top             =   240
      Width           =   480
   End
End
Attribute VB_Name = "msg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public rival As String

Private Sub Command1_Click()
hora = "[" & Time & "]"
principal.txtNotas.Text = principal.txtNotas.Text & hora & "Has aceptado el reto de " & rival & vbCrLf
principal.sock.SendData "05Aceptado  " & rival & " " & nick
Unload Me
End Sub

Private Sub Command2_Click()
hora = "[" & Time & "]"
principal.txtNotas.Text = principal.txtNotas.Text & hora & "Has rechazado el reto de " & rival & vbCrLf
principal.sock.SendData "05Rechazado " & rival & " " & nick
Unload Me
End Sub

