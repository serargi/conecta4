VERSION 5.00
Begin VB.Form sal_principal 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Salir"
   ClientHeight    =   1320
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3135
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1320
   ScaleWidth      =   3135
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Sí"
      Height          =   365
      Left            =   360
      TabIndex        =   1
      Top             =   840
      Width           =   1140
   End
   Begin VB.CommandButton Command2 
      Caption         =   "No"
      Height          =   365
      Left            =   1560
      TabIndex        =   0
      Top             =   840
      Width           =   1140
   End
   Begin VB.Image Image1 
      Height          =   1350
      Left            =   0
      Picture         =   "sal_principal.frx":0000
      Top             =   0
      Width           =   3045
   End
End
Attribute VB_Name = "sal_principal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
principal.Timer2.Enabled = True
End Sub

Private Sub Command2_Click()


End Sub
