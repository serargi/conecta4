VERSION 5.00
Begin VB.Form activas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tienes partidas activas"
   ClientHeight    =   1500
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4095
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1500
   ScaleWidth      =   4095
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Aceptar"
      Height          =   359
      Left            =   1518
      TabIndex        =   0
      Top             =   960
      Width           =   1105
   End
   Begin VB.Image Image1 
      Height          =   675
      Left            =   120
      Picture         =   "activas.frx":0000
      Top             =   120
      Width           =   3900
   End
End
Attribute VB_Name = "activas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
