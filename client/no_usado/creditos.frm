VERSION 5.00
Begin VB.Form creditos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About..."
   ClientHeight    =   2580
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3105
   Icon            =   "creditos.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2580
   ScaleWidth      =   3105
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   375
      Left            =   960
      TabIndex        =   0
      Top             =   2040
      Width           =   1215
   End
   Begin VB.Image Image1 
      Height          =   1935
      Left            =   0
      Picture         =   "creditos.frx":1782
      Top             =   0
      Width           =   3030
   End
End
Attribute VB_Name = "creditos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Unload Me
End Sub
