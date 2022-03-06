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
    Dim Vg_ClaveSol As Integer
    Dim Vg_ClaveSolPres As String
    Dim Vg_SecDescripcion As String

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
        Try
            If Not Session("UsuAppV") <> "" Then
                Server.Transfer("portal.aspx")
            End If
            vg_Clave = Session("Vs_Clave")
            SP_GetPermiso()

            If Not Page.IsPostBack() Then
                SP_GetSecretarias()
                Btn_Guardar.Enabled = False
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "App_SPGetPermisoByUser"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

            Dim miParam1 As New SqlParameter("@IdApp", SqlDbType.Int)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@IdApp").Value = 2

            Dim miParam2 As New SqlParameter("@IdModulo", SqlDbType.Int)
            miParam2.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam2)
            coDetalle.Parameters("@IdModulo").Value = 1


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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetU_SecretariaByUser"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            'AppV_SPGetSecretariaByUser
            Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")


            'Ejecutar el Store Procedure
            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            DDL_Secretarias.DataTextField = "Sec_Descripcion"
            DDL_Secretarias.DataValueField = "Sec_Clave"
            DDL_Secretarias.DataSource = registro
            DDL_Secretarias.DataBind()
            DDL_Secretarias.Items.Insert(0, "Selecciona una Secretaria")
            DDL_Secretarias.SelectedIndex = 0

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub ISP_GetSolicitudInsumo()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppI_SPGetSolicitudInsumo"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            Dim dtTable As New DataTable

            'Parámetros si hubieran

            If DDL_Secretarias.SelectedIndex > 0 Then
                Dim miParam As New SqlParameter("@Sec_Clave", SqlDbType.Int)
                miParam.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam)
                coDetalle.Parameters("@Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
            End If

            If Not Txt_Clave.Text.Trim.Equals("") Then
                Dim miParam2 As New SqlParameter("@ISol_ClavePres", SqlDbType.VarChar)
                miParam2.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam2)
                coDetalle.Parameters("@ISol_ClavePres").Value = Txt_Clave.Text.Trim
            End If

            Dim miParam3 As New SqlParameter("@ISot_Clave", SqlDbType.Int)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@ISot_Clave").Value = 2 'Por Aprobar

            Dim miParam6 As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
            miParam6.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam6)
            coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

            daDetalle.Fill(dtTable)
            GV_Solicitud.DataSource = dtTable
            GV_Solicitud.DataBind()

            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub ISP_GetInsumos()
        Dim myConnection As SqlConnection

        'CleanFields()
        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppI_SPGetInsumos"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            Dim dtTable As New DataTable

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@ISol_Clave", SqlDbType.Int)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@ISol_Clave").Value = CInt(Vg_ClaveSol)

            daDetalle.Fill(dtTable)
            GV_Insumos.DataSource = dtTable
            GV_Insumos.DataBind()
            If GV_Insumos.Rows.Count > 0 Then
                If Vg_Fac3 = 2 Then
                    Btn_Guardar.Enabled = True
                End If
                ' Btn_Modificar.Enabled = True
            Else
                Btn_Guardar.Enabled = False
                ' Btn_Modificar.Enabled = False
            End If

            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Insumos_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try
            If (e.Row.RowType = DataControlRowType.Header) Then
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(0).Font.Size = 8
                e.Row.Cells(1).Font.Size = 8
                e.Row.Cells(2).Font.Size = 8
                e.Row.Cells(3).Font.Size = 8
                e.Row.Cells(0).Text = "Tipo de Producto"
                e.Row.Cells(1).Text = "Producto"
                e.Row.Cells(2).Text = "Unidad Medida"
                e.Row.Cells(3).Text = "Cantidad"
            End If
            If (e.Row.RowType = DataControlRowType.DataRow) Then
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(0).Font.Size = 8
                e.Row.Cells(1).Font.Size = 8
                e.Row.Cells(2).Font.Size = 8
                e.Row.Cells(3).Font.Size = 8
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Solicitud_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try
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
                e.Row.Cells(10).Font.Size = 8
                e.Row.Cells(0).Text = "Sel"
                e.Row.Cells(1).Text = "Clave"
                e.Row.Cells(2).Text = "Secretaria"
                e.Row.Cells(3).Text = "Tipo"
                e.Row.Cells(4).Text = "Enlace"
                e.Row.Cells(10).Text = "Fecha Solicitud"
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
                e.Row.Cells(10).Font.Size = 8
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Solicitud_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = GV_Solicitud.SelectedRow

        Try
            Session("Vs_Clave") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("ISol_Clave"))
            Vg_ClaveSol = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("ISol_Clave"))
            Session("Vs_ClaveTexto") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("ISol_ClavePres"))
            Session("Vs_Secretaria") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("Sec_Descripcion"))
            Session("Vs_TraeCve") = 1
            ISP_GetInsumos()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub Btn_Modificar_Click(sender As Object, e As EventArgs)
        Response.Write("<script>window.open('AppI_SolicitudxInsumos.aspx',target='_self');<" & "/" & "script>")
    End Sub

    Sub ISP_SetSolicitudInsumoxFiltro()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppI_SPSetSolicitudInsumoxFiltro"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            Dim dtTable As New DataTable

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@ISol_Clave", SqlDbType.Int)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@ISol_Clave").Value = Session("Vs_Clave")

            Dim miParam1 As New SqlParameter("@ISot_Clave", SqlDbType.Int)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@ISot_Clave").Value = 3 ' Por Aprobar RM

            'Ejecutar el Store Procedure
            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            If registro.Read Then
                Session("Vs_Clave") = ""
                Vg_ClaveSol = 0
                Session("Vs_ClaveTexto") = ""
                Session("Vs_Secretaria") = ""
                Session("Vs_TraeCve") = 0
                Alert("Solicitud Aprobada")
                Response.Write("<script>window.open('AppI_SolicitudxAprobar.aspx',target='_self');<" & "/" & "script>")
            Else
                Alert("Ocurrio un Error. Favor de contactar al Administrador del Sistema.")
            End If

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub Alert(codigo As String)

        Response.Write("<script>window.alert('" & codigo & "');<" & "/" & "script>")

    End Sub

    Protected Sub DDL_Secretarias_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            GV_Solicitud.DataSource = Nothing
            GV_Solicitud.DataBind()
            GV_Insumos.DataSource = Nothing
            GV_Insumos.DataBind()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

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
    <title>App Insumos</title>
    <meta name="description" content="Aplicacion de Insumos">
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
                        <a href="index_Insumos.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Insumos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppI_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="ti-zoom-in"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppI_SolicitudXValidar.aspx" runat="server">Por Validar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppI_SolicitudXAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppI_SolicitudxAprobarRM.aspx" runat="server">Por Aprobar RM</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppI_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppI_SolicitudxVoBo.aspx" runat="server">VoBo</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                           
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppI_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
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
                    <a class="navbar-brand" href="portal.aspx"><img src="images/logo3.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="portal.aspx"><img src="images/logo2.png" alt="Logo"></a>
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
                        <strong class="card-title">Solicitudes / Por Aprobar</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud Clave: <%=Session("Vs_ClaveTexto") & "  " %> Por Aprobar</strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-8">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Unidad Presupuestal - Secretaria</label>
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="DDL_Secretarias" OnSelectedIndexChanged="DDL_Secretarias_SelectedIndexChanged" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="input-small" class=" form-control-label">Clave</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                                            <asp:TextBox ID="Txt_Clave" runat="server"  MaxLength="6"  class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="input-small" class=" form-control-label">Buscar</label>
                                                        <div class="input-group">
                                                            <asp:Button ID="Btn_Aceptar" OnClick="ISP_GetSolicitudInsumo"  runat="server" class="btn btn-warning" Text="Ok"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <asp:GridView ID="GV_Solicitud" runat="server" Width="100%" OnRowDataBound="GV_Solicitud_RowDataBound"
                                                            CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Solicitud_SelectedIndexChanged"
                                                            DataKeyNames="ISol_ClavePres,ISol_Clave,Sec_Clave,ISot_Clave,InT_Clave,IEn_Clave,Sec_Descripcion">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                            <Columns>
                                                                <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>

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
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Productos:</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <asp:GridView ID="GV_Insumos" runat="server" Width="100%" OnRowDataBound="GV_Insumos_RowDataBound"
                                                            CellPadding="4" ForeColor="#333333" GridLines="None" 
                                                            DataKeyNames="Ins_Clave,Prod_Clave, ISol_Clave, UnM_Clave">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

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
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <asp:Button ID="Btn_Guardar" OnClick="ISP_SetSolicitudInsumoxFiltro" runat="server"  class="btn btn-success btn-sm" Text="Aceptar" />
                                                    </div>
                                                </div>
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
                    <div class="col-sm-4 text-left">
                        <!--Copyright &copy; 2018 Empresa-->
                    </div>
                    <div class="col-sm-4 text-center">
                        <i class="fa fa-envelope"></i>
                        <asp:HyperLink ID="HyperLink16" NavigateUrl ="https://discord.gg/tdeNj3Bneh" runat="server">Contactanos</asp:HyperLink>
                    </div>
                    <div class="col-sm-4 text-right">
                        <!--Designed by <a href="smart.cen-pri.mx">Empresa</a>-->
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
