Imports System
Imports System.Data
Imports System.Configuration
Imports System.IO
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Public Class GridViewExportUtil

    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView, Optional ByVal DesdeColumna As Integer = 0, Optional ByVal DesdeFila As Integer = 0, Optional ByVal MostrarEncabezado As Boolean = True)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table

        If MostrarEncabezado And (Not (gv.HeaderRow) Is Nothing) Then
            GridViewExportUtil.PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If

        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            If row.RowIndex < DesdeFila Then Continue For

            GridViewExportUtil.PrepareControlForExport(row)
            table.Rows.Add(row)


            '///////////
            For i As Integer = 0 To row.Cells.Count - 1 'pintarrajeo
                Try
                    table.Rows(table.Rows.Count - 1).Cells(i).BackColor = CType(row.Cells(i).Controls(1), WebControls.Label).BackColor
                Catch ex As Exception
                End Try
            Next

        Next

        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            GridViewExportUtil.PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If



        'cómo borro las columnas invisibles?
        'For Each col As GridViewColn In gv.Columns
        ' GridViewExportUtil.PrepareControlForExport(row)
        ' table.Rows.Add(row)
        ' Next




        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub


    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
            ElseIf (TypeOf current Is GridView) Then

            End If
            If current.HasControls Then
                GridViewExportUtil.PrepareControlForExport(current) 'es recursiva, guardiola
            End If
            i = (i + 1)
        Loop
    End Sub
End Class

