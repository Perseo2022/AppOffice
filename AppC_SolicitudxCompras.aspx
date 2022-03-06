﻿<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
    Dim vg_Clave As String = ""
    Dim Vg_InsClave As Integer
    Dim Vg_ComEstatus As String

    Dim vg_Cantidad As Integer
    Dim vg_InsClave2 As Integer
    Dim vg_ProdClave As Integer
    Dim vg_ISolClave As Integer
    Dim vg_UnMClave As Integer

    'Variables de Permisos
    Dim Vg_mod1 As Integer
    Dim Vg_mod2 As Integer
    Dim Vg_mod3 As Integer
    Dim Vg_mod4 As Integer
    Dim Vg_mod5 As Integer
    Dim Vg_mod6 As Integer
    Dim Vg_mod7 As Integer
    Dim Vg_mod8 As Integer
    Dim Vg_mod9 As Integer
    Dim Vg_mod10 As Integer

    Dim Vg_Fac1 As Integer
    Dim Vg_Fac2 As Integer
    Dim Vg_Fac3 As Integer
    Dim Vg_Fac4 As Integer
    Dim Vg_Fac5 As Integer
    Dim Vg_Fac6 As Integer
    Dim Vg_Fac7 As Integer
    Dim Vg_Fac8 As Integer
    Dim Vg_Fac9 As Integer
    Dim Vg_Fac10 As Integer

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'If Not Session("UsuAppV") <> "" Then
        '    Server.Transfer("portal.aspx")
        'End If
        'Dim dsColumnas As New DataSet
        'If Not Session("Vs_Clave").Equals(vbNull) Then

        'End If
        vg_Clave = Session("Vs_Clave")
        Vg_ComEstatus = Session("Vs_InsEstatus")
        SP_GetPermiso()
        If Not Page.IsPostBack() Then

            'SP_GetSecretarias()
            'ISP_GetInsumosTipo()
            'ISP_GetEnlaces()
            'ISP_GetUniPptal()
            ISP_GetProdCat()
            If Session("Vs_TraeCve") = 1 Then
                Session("Vs_TraeCve") = 0
                CSP_GetCompras()
            End If
            If Session("Vs_InsEstatus") = "E" Then
                Btn_Guardar.Enabled = True
            Else
                Btn_Guardar.Enabled = False
            End If
        Else

        End If
    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppV_SPGetPermiso"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@vp_UsuUsuario", SqlDbType.Char)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@vp_UsuUsuario").Value = Session("UsuAppV")

        Dim miParam1 As New SqlParameter("@vp_PerClave", SqlDbType.Char)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@vp_PerClave").Value = CInt(Session("UsuPer"))

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        While registro.Read
            vg_Name = registro("Usu_Nombre").ToString
            vg_LastName = registro("Usu_ApPaterno").ToString
            Select Case CInt(registro("Mod_Clave").ToString)
                Case 1
                    Vg_mod1 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac1 = CInt(registro("Fac_Clave").ToString)
                Case 2
                    Vg_mod2 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac2 = CInt(registro("Fac_Clave").ToString)
                Case 3
                    Vg_mod3 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac3 = CInt(registro("Fac_Clave").ToString)
                Case 4
                    Vg_mod4 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac4 = CInt(registro("Fac_Clave").ToString)
                Case 5
                    Vg_mod5 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac5 = CInt(registro("Fac_Clave").ToString)
                Case 6
                    Vg_mod6 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac6 = CInt(registro("Fac_Clave").ToString)
                Case 7
                    Vg_mod7 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac7 = CInt(registro("Fac_Clave").ToString)
                Case 8
                    Vg_mod8 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac8 = CInt(registro("Fac_Clave").ToString)
                Case 9
                    Vg_mod9 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac9 = CInt(registro("Fac_Clave").ToString)
                Case 10
                    Vg_mod10 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac10 = CInt(registro("Fac_Clave").ToString)
            End Select

        End While

        registro.Close()
        myConnection.Close()

    End Sub

    Sub ISP_GetProdCat()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetProdCat"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        'Dim miParam As New SqlParameter("@Usu_Clave", SqlDbType.VarChar)
        'miParam.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam)
        'coDetalle.Parameters("@Usu_Clave").Value = vl_cveusu

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_ProductoTipo.DataTextField = "CaP_Descripcion"
        DDL_ProductoTipo.DataValueField = "CaP_Clave"
        DDL_ProductoTipo.DataSource = registro
        DDL_ProductoTipo.DataBind()
        DDL_ProductoTipo.Items.Insert(0, "Sel Tipo Producto")

        registro.Close()
        myConnection.Close()
    End Sub

    Sub ISP_GetProducto()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetProducto"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@CaP_Clave", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@CaP_Clave").Value = DDL_ProductoTipo.SelectedValue

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_Producto.DataTextField = "Prod_Descripcion"
        DDL_Producto.DataValueField = "Prod_Clave"
        DDL_Producto.DataSource = registro
        DDL_Producto.DataBind()
        DDL_Producto.Items.Insert(0, "Sel un Tipo")

        registro.Close()
        myConnection.Close()
        ISP_GetUnidadMed()
    End Sub


    Sub ISP_GetUnidadMed()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetUnidadMed"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_UniMed.DataTextField = "UnM_Descripcion"
        DDL_UniMed.DataValueField = "UnM_Clave"
        DDL_UniMed.DataSource = registro
        DDL_UniMed.DataBind()
        DDL_UniMed.Items.Insert(0, "Sel una Unidad")

        registro.Close()
        myConnection.Close()
    End Sub

    Sub CSP_SetCompras()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPSetCompras"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran

        Dim miParam As New SqlParameter("@Com_Cantidad", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        If Vg_ComEstatus = "C" Then
            coDetalle.Parameters("@Com_Cantidad").Value = vg_Cantidad
        Else
            coDetalle.Parameters("@Com_Cantidad").Value = CInt(Txt_Cantidad.Text.Trim)
        End If
        If Vg_ComEstatus = "C" Then
            Dim miParam1 As New SqlParameter("@Prod_Clave", SqlDbType.Int)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@Prod_Clave").Value = vg_ProdClave
        Else
            If DDL_Producto.SelectedIndex > 0 Then
                Dim miParam1 As New SqlParameter("@Prod_Clave", SqlDbType.Int)
                miParam1.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam1)
                coDetalle.Parameters("@Prod_Clave").Value = CInt(DDL_Producto.Items(DDL_Producto.SelectedIndex).Value)
            End If
        End If

        If Vg_ComEstatus = "C" Then
            Dim miParam2 As New SqlParameter("@CSol_Clave", SqlDbType.Int)
            miParam2.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam2)
            coDetalle.Parameters("@CSol_Clave").Value = vg_ISolClave
        Else
            Dim miParam2 As New SqlParameter("@CSol_Clave", SqlDbType.Int)
            miParam2.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam2)
            coDetalle.Parameters("@CSol_Clave").Value = CInt(vg_Clave)
        End If

        If Vg_ComEstatus = "C" Then
            Dim miParam3 As New SqlParameter("@UnM_Clave", SqlDbType.Int)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@UnM_Clave").Value = vg_UnMClave
            Dim miParam4 As New SqlParameter("@Com_Estatus", SqlDbType.Char)
            miParam4.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam4)
            coDetalle.Parameters("@Com_Estatus").Value = "E"
        Else
            If DDL_UniMed.SelectedIndex > 0 Then
                Dim miParam3 As New SqlParameter("@UnM_Clave", SqlDbType.Int)
                miParam3.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam3)
                coDetalle.Parameters("@UnM_Clave").Value = CInt(DDL_UniMed.Items(DDL_UniMed.SelectedIndex).Value)
            End If
            Dim miParam4 As New SqlParameter("@Com_Estatus", SqlDbType.Char)
            miParam4.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam4)
            coDetalle.Parameters("@Com_Estatus").Value = Vg_ComEstatus
        End If



        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        If registro.Read Then
            'vl_Respuesta = registro(0).ToString
            'MsgBox("Solicitud Creada", MsgBoxStyle.Information, "AppInsumos")
            'Response.Write("<script>javascript: alert('Solicitud Completada: " & vl_Respuesta & "');<" & "/" & "script>")
            'Response.Write("<script>window.open('AppV_SolicitudNew.aspx',target='_self');<" & "/" & "script>")
            'Response.Redirect("index.html", False)
            'Session("Vs_Clave") = ""
            'Server.Transfer("AppI_SolicitudxInsumos.aspx")
        Else
            MsgBox("Ocurrio un Error. Favor de contactar al Administrador del Sistema.", MsgBoxStyle.Critical, "AppInsumos")
        End If

        myConnection.Close()

        If Not Vg_ComEstatus.Equals("C") Then
            CSP_GetCompras()
        End If

    End Sub

    Sub CSP_GetCompras()
        Dim myConnection As SqlConnection

        'CleanFields()

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPGetCompras"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@CSol_Clave", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@CSol_Clave").Value = CInt(vg_Clave)

        Dim miParam1 As New SqlParameter("@Com_Estatus", SqlDbType.Char)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@Com_Estatus").Value = "E"



        'ImageButton1.Enabled = True
        'MsgBox(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)

        daDetalle.Fill(dtTable)
        GV_Compras.DataSource = dtTable
        GV_Compras.DataBind()

        myConnection.Close()

        DDL_Producto.SelectedIndex = 0
        DDL_ProductoTipo.SelectedIndex = 0
        DDL_UniMed.SelectedIndex = 0
        Txt_Cantidad.Text = ""

        'Response.Write("<script>javascript: document.getElementById('scrollmodal').style.display = 'block';<" & "/" & "script>")
    End Sub

    Protected Sub GV_Compras_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
            e.Row.Cells(4).Font.Size = 8
            'e.Row.Cells(0).Width = "10"
            'e.Row.Cells(1).Width = "20"
            'e.Row.Cells(2).Width = "40"
            'e.Row.Cells(3).Width = "10"
            'e.Row.Cells(4).Width = "10"
            'e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(2).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(4).HorizontalAlign = HorizontalAlign.Center
            e.Row.Cells(0).Text = "Sel"
            e.Row.Cells(1).Text = "Tipo de Producto"
            e.Row.Cells(2).Text = "Producto"
            e.Row.Cells(3).Text = "Unidad Medida"
            e.Row.Cells(4).Text = "Cantidad"
        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
            e.Row.Cells(4).Font.Size = 8
            'e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(2).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Center
            'e.Row.Cells(4).HorizontalAlign = HorizontalAlign.Center
        End If
    End Sub

    Protected Sub DDL_ProductoTipo_SelectedIndexChanged(sender As Object, e As EventArgs)
        ISP_GetProducto()
    End Sub

    Protected Sub GV_Compras_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim Vl_ComClave As Integer = 0
        Dim myConnection As SqlConnection

        Dim row As GridViewRow = GV_Compras.SelectedRow

        Vl_ComClave = Convert.ToString(GV_Compras.DataKeys(row.RowIndex).Values("Com_Clave"))

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPDelCompras"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran

        Dim miParam As New SqlParameter("@Com_Clave", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@Com_Clave").Value = Vl_ComClave

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        If registro.Read Then
            'vl_Respuesta = registro(0).ToString
            'MsgBox("Solicitud Creada", MsgBoxStyle.Information, "AppInsumos")
            'Response.Write("<script>javascript: alert('Solicitud Completada: " & vl_Respuesta & "');<" & "/" & "script>")
            'Response.Write("<script>window.open('AppV_SolicitudNew.aspx',target='_self');<" & "/" & "script>")
            'Response.Redirect("index.html", False)
            'Session("Vs_Clave") = ""
            'Server.Transfer("AppI_SolicitudxInsumos.aspx")
        Else
            MsgBox("Ocurrio un Error. Favor de contactar al Administrador del Sistema.", MsgBoxStyle.Critical, "AppInsumos")
        End If

        myConnection.Close()

        CSP_GetCompras()
    End Sub

    Sub CSP_SetSolicitudComprasxFiltro()

        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPSetSolicitudComprasxFiltro"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@CSol_Clave", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@CSol_Clave").Value = vg_Clave

        Dim miParam1 As New SqlParameter("@CSot_Clave", SqlDbType.Int)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@CSot_Clave").Value = 6 ' Por Surtir

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        If registro.Read Then
            Session("Vs_Clave") = ""
            Session("Vs_ClaveTexto") = ""
            Session("Vs_Secretaria") = ""
            Session("Vs_TraeCve") = 0
            myConnection.Close()
            If Vg_ComEstatus = "E" Then
                If ConfirmaCompras() Then
                    CSP_GetCompras()
                End If
            End If
            Response.Write("<script>javascript: alert('Solicitud Con VoBo');<" & "/" & "script>")
            Server.Transfer("AppC_SolicitudxComprar.aspx")
        Else
            MsgBox("Ocurrio un Error. Favor de contactar al Administrador del Sistema.", MsgBoxStyle.Critical, "AppInsumos")
        End If

    End Sub

    Function ConfirmaCompras() As Boolean
        Dim vl_ComEstatus As String = ""
        ConfirmaCompras = False
        Vg_ComEstatus = "C"
        For Each Fila As GridViewRow In GV_Compras.Rows
            'Ins_Cantidad,Ins_Clave,Prod_Clave, ISol_Clave, UnM_Clave
            vg_Cantidad = Convert.ToInt32(Me.GV_Compras.DataKeys(Fila.RowIndex).Values("Com_Cantidad"))
            vg_InsClave2 = Convert.ToInt32(Me.GV_Compras.DataKeys(Fila.RowIndex).Values("Com_Clave"))
            vg_ProdClave = Convert.ToInt32(Me.GV_Compras.DataKeys(Fila.RowIndex).Values("Prod_Clave"))
            vg_ISolClave = Convert.ToInt32(Me.GV_Compras.DataKeys(Fila.RowIndex).Values("CSol_Clave"))
            vg_UnMClave = Convert.ToInt32(Me.GV_Compras.DataKeys(Fila.RowIndex).Values("UnM_Clave"))
            vl_ComEstatus = Me.GV_Compras.DataKeys(Fila.RowIndex).Values("Com_Estatus")

            If vl_ComEstatus.Equals("S") Then
                CSP_SetCompras()
            End If
        Next

        ConfirmaCompras = True
    End Function

</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
 <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>App Compras</title>
    <meta name="description" content="Aplicacion de Compras">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
    <link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
    <link href="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/jqvmap@1.5.1/dist/jqvmap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/weathericons@2.1.0/css/weather-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.css" rel="stylesheet" />

    <style>
        #weatherWidget .currentDesc {
            color: #ffffff !important;
        }

        .traffic-chart {
            min-height: 335px;
        }

        #flotPie1 {
            height: 150px;
        }

            #flotPie1 td {
                padding: 3px;
            }

            #flotPie1 table {
                top: 20px !important;
                right: -10px !important;
            }

        .chart-container {
            display: table;
            min-width: 270px;
            text-align: left;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        #flotLine5 {
            height: 105px;
        }

        #flotBarChart {
            height: 150px;
        }

        #cellPaiChart {
            height: 160px;
        }
    </style>
</head>

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index_Compras.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Compras</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppC_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="ti-zoom-in"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppC_SolicitudXValidarE.aspx" runat="server">Por Validar E</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppC_SolicitudXAprobarCE.aspx" runat="server">Por Aprobar CE</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppC_SolicitudxValidarC.aspx" runat="server">Por Validar C</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="ti-check-box"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppC_SolicitudxAprobarSA.aspx" runat="server">Por Aprobar SA</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-money"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppC_SolicitudxComprar.aspx" runat="server">Por Comprar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink7" NavigateUrl ="AppC_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink8" NavigateUrl ="AppC_SolicitudxVoBo.aspx" runat="server">Por VoBo</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-email"></i><asp:HyperLink ID="HyperLink9" NavigateUrl ="AppC_SolicitudxNotificar.aspx" runat="server">Por Notificar</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppC_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
    <div id="right-panel" class="right-panel">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="./"><img src="images/logo4.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="images/logo2.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>

            <div class="top-right">
                <div class="header-menu">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="images/user.png" alt="User Avatar">
                        </a>
                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="./MiPerfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="./" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">

           <form id="form1" method = "post" runat="server" target="_self">

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Solicitudes / Detalle</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud Clave: <%=Session("Vs_ClaveTexto")%></strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                    <table class="table ">
                                        <tbody>
                                            <tr>
                                                <td width="20%">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <label for="input-small" class=" form-control-label ">Tipo de Producto</label>
                                                            <div class="input-group">
                                                                <asp:DropDownList Font-Size="XX-Small" ID="DDL_ProductoTipo" OnSelectedIndexChanged="DDL_ProductoTipo_SelectedIndexChanged" class="form-control-sm form-control" runat="server" AutoPostBack="True"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="30%">
                                                    <div class="form-group">
                                                        <label for="input-small" class=" form-control-label">Producto</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList Font-Size="XX-Small" ID="DDL_Producto" class="form-control-sm form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td width="20%">
                                                    <div class="form-group">
                                                        <label for="input-small" class=" form-control-label">Unidad Medida</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList Font-Size="XX-Small" ID="DDL_UniMed"  class="form-control-sm form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="20%">
                                                    <div class="form-group">
                                                        <label for="input-small" class=" form-control-label">Cantidad</label>
                                                        <div class="input-group">
                                                            <asp:TextBox Font-Size="XX-Small" ID="Txt_Cantidad" runat="server"  MaxLength="10"  class="input-sm form-control-sm form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="10%">
                                                    <div class="form-group">
                                                        <label for="input-small" class=" form-control-label">Agregar</label>
                                                        <div class="input-group">
                                                            <asp:Button ID="Btn_Aceptar" OnClick="CSP_SetCompras"  runat="server"  class="btn btn-success btn-sm" Text="Ok" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5" width="100%">
                                                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="240px">
                                                    <div class="form-group">
                                                        <asp:GridView ID="GV_Compras" runat="server" Width="100%" OnRowDataBound="GV_Compras_RowDataBound"
                                                            CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Compras_SelectedIndexChanged"
                                                            DataKeyNames="Com_Cantidad, Com_Clave,Prod_Clave, CSol_Clave, UnM_Clave, Com_Estatus">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                            <Columns>
                                                                <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/btn_eliminar.png"></asp:CommandField>

                                                            </Columns>

                                                            <EditRowStyle BackColor="#999999"></EditRowStyle>

                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                                                            <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>

                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                                                            <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                                                            <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                                                            <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                                                        </asp:GridView>
                                                    </div>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5" width="100%"  style="text-align:center">
                                                    <div class="form-group">
                                                        <asp:Button ID="Btn_Guardar" OnClick="CSP_SetSolicitudComprasxFiltro" runat="server"  class="btn btn-success btn-sm" Text="Confirmar" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <!-- /.table-stats -->
                                </div>
                            </div>
                        <!-- /Solicitud -->
                        </div>

                      
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

            </form>

        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
        <footer class="site-footer">
            <div class="footer-inner bg-white">
                <div class="row">
                    <div class="col-sm-6">
                        Copyright &copy; 2018 Empresa
                    </div>
                    <div class="col-sm-6 text-right">
                        Designed by <a href="https://colorlib.com">Empresa</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- /.site-footer -->
    </div>
    <!-- /#right-panel -->
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

    <!--  Chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script>

    <!--Chartist Chart-->
    <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartist-plugin-legend@0.6.2/chartist-plugin-legend.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery.flot@0.8.3/jquery.flot.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-pie@1.0.0/src/jquery.flot.pie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-spline@0.0.1/js/jquery.flot.spline.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/simpleweather@3.1.0/jquery.simpleWeather.min.js"></script>
    <script src="assets/js/init/weather-init.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="assets/js/init/fullcalendar-init.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#bootstrap-data-table-export').DataTable();
        });
    </script>
</body>
</html>
