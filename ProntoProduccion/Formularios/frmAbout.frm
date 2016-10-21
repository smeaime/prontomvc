VERSION 5.00
Begin VB.Form frmAbout 
   BackColor       =   &H00FFFFFF&
   Caption         =   "Acerca de"
   ClientHeight    =   2880
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7485
   FillColor       =   &H00FFFFFF&
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2880
   ScaleWidth      =   7485
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      Height          =   2580
      Left            =   0
      ScaleHeight     =   2520
      ScaleWidth      =   7470
      TabIndex        =   2
      Top             =   0
      Width           =   7530
   End
   Begin VB.CommandButton cmd 
      BackColor       =   &H80000005&
      Caption         =   "&Salir"
      Height          =   330
      Left            =   6705
      TabIndex        =   0
      Top             =   2565
      Width           =   780
   End
   Begin VB.Label lclWebLink 
      BackColor       =   &H80000005&
      Caption         =   "http://www.bdlconsultores.com.ar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   45
      MouseIcon       =   "frmAbout.frx":076A
      MousePointer    =   99  'Custom
      TabIndex        =   3
      Top             =   2610
      Width           =   2475
   End
   Begin VB.Label lblVersion 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   2160
      TabIndex        =   1
      Top             =   1485
      Width           =   3255
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit 'Keeps me from being sloppy :-)
Dim XPos, YPos As Integer 'Current X and Y positions of the "laser"
Dim Color As Long 'The color that the "laser" is currentlly drawing

Dim vLeft As Boolean, hLeft As Boolean

Private Enum LaserDrawModes
    LaserCorner
    PrinterScan
    WierdDraw
    WierdDrawSlow
End Enum

'LaserDraw
'**** Description ***********
'Copies a picture from one picture box (or form) to another, with an animated "laser" effect
'**** Usage ***************
'LaserDraw PictureToDraw, DrawSurface, LaserOriginX, LaserOriginY, BackColor
'**** Inputs ***************
'0 PictureToDraw - Picturebox containing the picture to be copied
'0 DrawSurface - Picturebox or Form which the picture should be copied to
'0 LaserOriginX - Optional; The x coordinate of where the laser should come from.
'   Default is the width of the PictureToDraw picture box
'0 LaserOriginY - Optional; The y coordinate of where the laser should come from.
'   Default is the height of the PictureToDraw picture box
'0 BackColor - Optional; The background color of the DrawSurface
'   Default is the current background color of DrawSurface
'0 LaserDrawMode - Optional; The style of the laser draw
'   LaserCorner - Original mode, draws the picture, one line at a time, as if from a laser in a corner
'   PrinterScan - Draws the picture as if a printer were going along and drawing each dot
'   WierdDraw - Wierd draw mode, similar to PrinterScan. Try it for yourself :-)
'   Default is LaserCorner
'**** Outputs *****************
'None

Private Sub LaserDraw(PictureToDraw As PictureBox, DrawSurface As Object, Optional LaserOriginX = -1, Optional LaserOriginY = -1, Optional BackColor As ColorConstants = -1, Optional LaserDrawMode As LaserDrawModes = LaserCorner)
    'Set up the DrawSurface picture box
        DrawSurface.ScaleMode = vbPixels 'Set the scale mode of the "canvas" to pixels
        If BackColor <> -1 Then 'Background color specified
            DrawSurface.BackColor = BackColor 'Set the background color of the "canvas" to the desired background color
        End If
    'Set up the PictureToDraw picture box
        PictureToDraw.ScaleMode = vbPixels 'Set the scale mode of the picturebox containing the picture to be drawn to pixels
        PictureToDraw.AutoRedraw = True 'Set the autoredraw property of the picturebox containing the picture to be drawn to true
        PictureToDraw.Visible = False 'Hide the picturebox containing the picture to be drawn
    'Set up the X and Y coordinates of the "laser"
        If LaserOriginX = -1 Then 'No X coordinate of the "laser" is specified
            LaserOriginX = PictureToDraw.ScaleWidth 'Set it to the width of the picturebox containing the picture to be drawn
        End If
        If LaserOriginY = -1 Then 'No Y coordinate of the "laser" is specified
            LaserOriginY = PictureToDraw.ScaleHeight 'Set it to the height of the picturebox containing the picture to be drawn
        End If
    'Start the "Laser" effect
        For XPos = 0 To PictureToDraw.ScaleWidth 'Move the "laser" horizantally along the "canvas"
            DoEvents 'Allow input to be prosessed
            For YPos = 0 To PictureToDraw.ScaleHeight 'Move the "laser" verticlly along the "canvas"
                Color = PictureToDraw.Point(XPos, YPos) 'Determine the color of the pixel to be drawn
                If LaserDrawMode = LaserCorner Then 'Normal Drawing
                    DrawSurface.Line (XPos, YPos)-(LaserOriginX, LaserOriginY), Color 'Draw a line from the origin coordinates to the coordinates of the pixel to be drawn
                ElseIf LaserDrawMode = PrinterScan Then '"Printer Scanning" mode
                    DrawSurface.Line (XPos, YPos)-(LaserOriginX, YPos), Color 'Draw a straight line from the pixel to LaserOrginX
                    DrawSurface.Line (XPos + 1, YPos - 1)-(LaserOriginX, YPos - 1), BackColor 'Erase the last position of the "laser"
                    DoEvents 'Alow input to be prosessed
                ElseIf LaserDrawMode = WierdDrawSlow Then '"Weird Draw Slow" mode
                    DrawSurface.Line (XPos, YPos)-(LaserOriginX, YPos), Color 'Draw a straight line from the pixel to LaserOrginX
                    DoEvents 'Alow input to be prosessed
                Else '"Wierd Draw" mode
                    DrawSurface.Line (XPos, YPos)-(LaserOriginX, YPos), Color 'Draw a straight line from the pixel to LaserOrginX
                End If
            Next
        Next
End Sub

Private Sub Form_Activate()

   Me.Refresh
   LaserDraw Picture1, Me, Me.ScaleWidth, Me.ScaleHeight, vbBlack, WierdDraw
   
End Sub

Private Sub Form_Load()
   
'   lblVersion.Caption = "Version " & App.Major & "." & App.Minor
    'While True
        'LaserDraw Picture1, Me, Me.ScaleWidth, Me.ScaleHeight, vbBlack, LaserCorner
        'Me.Cls
        'LaserDraw Picture1, Me, Me.ScaleWidth, Me.ScaleHeight, vbBlack, WierdDraw
        'Me.Cls
        'LaserDraw Picture1, Me, Me.ScaleWidth, Me.ScaleHeight, vbBlack, WierdDrawSlow
        'Me.Cls
        'LaserDraw Picture1, Me, Me.ScaleWidth, Me.ScaleHeight, vbBlack, PrinterScan
    'Wend

   On Error Resume Next
   Dim mLogo As String
'   mLogo = "" & App.Path & "\Imagenes\" & glbEmpresaSegunString & ".jpg"
   mLogo = "" & glbPathPlantillas & "\..\Imagenes\BDL.jpg"
   If Len(Trim(Dir(mLogo))) <> 0 Then
      Picture1.Picture = LoadPicture(mLogo)
   End If

End Sub

Private Sub Cmd_Click()

   Me.Hide

End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    lclWebLink.ForeColor = vbBlue

End Sub

Private Sub lclWebLink_Click()

    lclWebLink.ForeColor = vbBlue
    ShellExecute 0, "Open", lclWebLink.Caption, "", "", vbNormalFocus
    Unload Me

End Sub

Private Sub lclWebLink_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    lclWebLink.ForeColor = vbRed

End Sub
