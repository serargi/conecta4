VERSION 5.00
Begin VB.Form sal_tablero 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Salir"
   ClientHeight    =   1425
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4320
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1425
   ScaleWidth      =   4320
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Sí"
      Height          =   365
      Left            =   960
      TabIndex        =   1
      Top             =   880
      Width           =   1140
   End
   Begin VB.CommandButton Command2 
      Caption         =   "No"
      Height          =   365
      Left            =   2160
      TabIndex        =   0
      Top             =   880
      Width           =   1140
   End
   Begin VB.Image Image1 
      Height          =   765
      Left            =   0
      Picture         =   "sal_tablero.frx":0000
      Top             =   0
      Width           =   4290
   End
End
Attribute VB_Name = "sal_tablero"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public rival As String
Public gana As Boolean

Private Sub Command1_Click()
            
End Sub

Private Sub Form_Load()

End Sub
