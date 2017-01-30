VERSION 5.00
Begin VB.Form completa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Movimiento erroneo"
   ClientHeight    =   1350
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   2385
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   2385
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   800
      Left            =   0
      Picture         =   "completa.frx":0000
      ScaleHeight     =   795
      ScaleWidth      =   2415
      TabIndex        =   1
      Top             =   0
      Width           =   2415
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   359
      Left            =   645
      TabIndex        =   0
      Top             =   840
      Width           =   1105
   End
End
Attribute VB_Name = "completa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Unload Me

End Sub
