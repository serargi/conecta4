VERSION 5.00
Begin VB.Form login 
   BackColor       =   &H00000000&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Autentificación de usuario"
   ClientHeight    =   1740
   ClientLeft      =   8205
   ClientTop       =   2955
   ClientWidth     =   3870
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1740
   ScaleWidth      =   3870
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtLogin 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   285
      Left            =   1200
      MaxLength       =   12
      TabIndex        =   0
      Top             =   240
      Width           =   2415
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   0
      Top             =   0
   End
   Begin VB.TextBox txtPass 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   285
      Left            =   1200
      MaxLength       =   12
      TabIndex        =   1
      Top             =   720
      Width           =   2415
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   255
      Left            =   1200
      TabIndex        =   4
      Top             =   1800
      Width           =   375
   End
   Begin VB.Image cmdReg 
      Height          =   420
      Left            =   600
      Picture         =   "login.frx":0000
      Top             =   1200
      Width           =   1365
   End
   Begin VB.Image cmdLogin 
      Appearance      =   0  'Flat
      Height          =   420
      Left            =   2280
      Picture         =   "login.frx":4462
      Top             =   1200
      Width           =   1365
   End
   Begin VB.Image cmdRe 
      Height          =   435
      Left            =   360
      Picture         =   "login.frx":62D4
      Top             =   1800
      Width           =   1275
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Password:"
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
      Left            =   360
      TabIndex        =   3
      Top             =   750
      Width           =   780
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Usuario:"
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
      Height          =   255
      Left            =   480
      TabIndex        =   2
      Top             =   285
      Width           =   735
   End
End
Attribute VB_Name = "login"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Login, Pass As String


Private Sub cmdLogin_Click()
cmdLogin.Enabled = False
cmdReg.Enabled = False
Timer1.Enabled = True


Login = txtLogin.Text
Pass = txtPass.Text

If Len(txtLogin.Text) < 1 Or Len(txtPass.Text) < 1 Then

MsgBox "Los campos USUARIO/PASSWORD no pueden estar vacios", vbCritical, "Error haciendo login"

Else
'pathWait = App.Path & "/wait.exe"
'Shell pathWait, vbNormalFocus
'Shell "wait.exe", vbNormalFocus
'KillProcess ("wait.exe")


Dim i As Integer
For i = Len(txtLogin.Text) To 12
txtLogin.Text = txtLogin.Text & " "
Next i


For i = Len(txtPass.Text) To 12
txtPass.Text = txtPass.Text & " "
Next i

principal.sock.SendData "01" & txtLogin.Text & txtPass.Text

End If

End Sub

Public Sub KillProcess(ByVal processName As String)
On Error GoTo ErrHandler
Dim oWMI
Dim ret
Dim sService
Dim oWMIServices
Dim oWMIService
Dim oServices
Dim oService
Dim servicename
Set oWMI = GetObject("winmgmts:")
Set oServices = oWMI.InstancesOf("win32_process")
For Each oService In oServices

servicename = LCase(Trim(CStr(oService.Name) & ""))

If InStr(1, servicename, LCase(processName), vbTextCompare) > 0 Then
ret = oService.Terminate
End If

Next

Set oServices = Nothing
Set oWMI = Nothing

ErrHandler:
Err.Clear
End Sub

Private Sub cmdReg_Click()
cmdLogin.Enabled = False
cmdReg.Enabled = False
Timer1.Enabled = True

Login = txtLogin.Text
Pass = txtPass.Text

If Len(txtLogin.Text) < 1 Or Len(txtPass.Text) < 1 Then

MsgBox "Los campos USUARIO/PASSWORD no pueden estar vacios", vbCritical, "Error registrando"

Else

Dim i As Integer
For i = Len(txtLogin.Text) To 12
txtLogin.Text = txtLogin.Text & " "
Next i


For i = Len(txtPass.Text) To 12
txtPass.Text = txtPass.Text & " "
Next i
principal.sock.SendData "02" & txtLogin.Text & txtPass.Text


End If
cmdLogin.Enabled = True
cmdReg.Enabled = True
End Sub

Private Sub Command1_Click()
txtLogin.Text = Login
txtPass.Text = Pass

End Sub

Private Sub Form_Load()
txtPass.PasswordChar = "*"
End Sub

Private Sub Image1_Click()

End Sub

Private Sub Timer1_Timer()
cmdLogin.Enabled = True
cmdReg.Enabled = True
Timer1.Enabled = False
End Sub

Private Sub txtLogin_GotFocus()
txtLogin.SelStart = 0
txtLogin.SelLength = Len(txtLogin)
End Sub

Private Sub txtLogin_KeyPress(KeyAscii As Integer)
 Const Number$ = "0123456789qQwWeErRtTyYuUIioOpPaAsSdDfFgGhHjJkKlLñÑzZxXcCvVbBnNmM" ' only allow these characters

    If KeyAscii <> 8 Then
    If InStr(Number$, Chr(KeyAscii)) = 0 Then
            KeyAscii = 0
            Exit Sub
        End If
    End If
End Sub

Private Sub txtPass_GotFocus()
txtPass.SelStart = 0
txtPass.SelLength = Len(txtPass)
End Sub

Private Sub txtPass_KeyPress(KeyAscii As Integer)
Const Number$ = "0123456789qQwWeErRtTyYuUIioOpPaAsSdDfFgGhHjJkKlLñÑzZxXcCvVbBnNmM" ' only allow these characters

    If KeyAscii <> 8 Then
    If InStr(Number$, Chr(KeyAscii)) = 0 Then
            KeyAscii = 0
            Exit Sub
        End If
    End If
End Sub
