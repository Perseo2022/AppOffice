<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
    Dim vg_Clave As String = ""

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
        If Session("UsuAppV") = "" Then
            FormsAuthentication.SignOut()
            Response.Redirect("./../login.aspx")
        End If
        'Dim dsColumnas As New DataSet
        'If Not Session("Vs_Clave").Equals(vbNull) Then

        'End If
        vg_Clave = Session("Vs_Clave")
        If Not Page.IsPostBack() Then
            'SP_GetPermiso()
            'SP_GetSecretarias()
            'ISP_GetInsumosTipo()
            'ISP_GetEnlaces()
            'ISP_GetUniPptal()
            ISP_GetProdCat()
        End If
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
        Dim miParam As New SqlParameter("@CaP_ClaveProd", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@CaP_ClaveProd").Value = DDL_ProductoTipo.SelectedValue

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

    Sub ISP_SetSolicitudNew()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPSetSolicitudNew"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran

        Dim miParam As New SqlParameter("@Ins_Cantidad", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@Ins_Cantidad").Value = CInt(Txt_Cantidad.Text.Trim)

        If DDL_Producto.SelectedIndex > 0 Then
            Dim miParam1 As New SqlParameter("@Prod_Clave", SqlDbType.Int)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@Prod_Clave").Value = CInt(DDL_Producto.Items(DDL_Producto.SelectedIndex).Value)
        End If

        Dim miParam2 As New SqlParameter("@ISol_Clave", SqlDbType.Int)
        miParam2.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam2)
        coDetalle.Parameters("@ISol_Clave").Value = CInt(vg_Clave)

        If DDL_UniMed.SelectedIndex > 0 Then
            Dim miParam3 As New SqlParameter("@UnM_Clave", SqlDbType.Char)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@UnM_Clave").Value = CInt(DDL_UniMed.Items(DDL_UniMed.SelectedIndex).Value)
        End If

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        If registro.Read Then
            vl_Respuesta = registro(0).ToString
            'MsgBox("Solicitud Creada", MsgBoxStyle.Information, "AppInsumos")
            Response.Write("<script>javascript: alert('Solicitud Completada: " & vl_Respuesta & "');<" & "/" & "script>")
            'Response.Write("<script>window.open('AppV_SolicitudNew.aspx',target='_self');<" & "/" & "script>")
            'Response.Redirect("index.html", False)
            'Session("Vs_Clave") = ""
            'Server.Transfer("AppI_SolicitudxNew.aspx")
        Else
            MsgBox("Ocurrio un Error. Favor de contactar al Administrador del Sistema.", MsgBoxStyle.Critical, "AppInsumos")
        End If

        myConnection.Close()
    End Sub

    'Sub SP_GetSolicitudxFiltro()
    '    Dim myConnection As SqlConnection

    '    CleanFields()

    '    myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
    '    myConnection.Open()

    '    'Definir un SQLCommand, El nombre del Store Procedure en CommandText
    '    'El CommandType = StoreProcedure y la conexion
    '    Dim coDetalle As New SqlCommand
    '    coDetalle.CommandText = "AppV_SPGetSolicitudxFiltro"
    '    coDetalle.CommandType = CommandType.StoredProcedure
    '    coDetalle.Connection = myConnection  'Previamente definida

    '    'El Adaptador y su SelectCommand
    '    Dim daDetalle As New SqlDataAdapter
    '    daDetalle.SelectCommand = coDetalle

    '    Dim dtTable As New DataTable

    '    'Parámetros si hubieran
    '    Dim miParam As New SqlParameter("@vp_Pas_Nombre", SqlDbType.VarChar)
    '    miParam.Direction = ParameterDirection.Input
    '    coDetalle.Parameters.Add(miParam)
    '    coDetalle.Parameters("@vp_Pas_Nombre").Value = Txt_Nombre.Text.Trim

    '    Dim miParam1 As New SqlParameter("@vp_Pas_ApPaterno", SqlDbType.VarChar)
    '    miParam1.Direction = ParameterDirection.Input
    '    coDetalle.Parameters.Add(miParam1)
    '    coDetalle.Parameters("@vp_Pas_ApPaterno").Value = Txt_ApPaterno.Text.Trim

    '    Dim miParam2 As New SqlParameter("@vp_Pas_ApMaterno", SqlDbType.VarChar)
    '    miParam2.Direction = ParameterDirection.Input
    '    coDetalle.Parameters.Add(miParam2)
    '    coDetalle.Parameters("@vp_Pas_ApMaterno").Value = Txt_ApMaterno.Text.Trim

    '    Dim miParam3 As New SqlParameter("@Sol_Clave", SqlDbType.VarChar)
    '    miParam3.Direction = ParameterDirection.Input
    '    coDetalle.Parameters.Add(miParam3)
    '    coDetalle.Parameters("@Sol_Clave").Value = Txt_ApMaterno.Text.Trim

    '    Dim miParam5 As New SqlParameter("@Sot_Clave", SqlDbType.Int)
    '    miParam5.Direction = ParameterDirection.Input
    '    coDetalle.Parameters.Add(miParam5)
    '    coDetalle.Parameters("@Sot_Clave").Value = 2 ' Por Validar

    '    If DDL_Secretarias.SelectedIndex > 0 Then
    '        Dim miParam4 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
    '        miParam4.Direction = ParameterDirection.Input
    '        coDetalle.Parameters.Add(miParam4)
    '        coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
    '    End If

    '    ImageButton1.Enabled = True
    '    'MsgBox(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)

    '    daDetalle.Fill(dtTable)
    '    GV_Pasajero.DataSource = dtTable
    '    GV_Pasajero.DataBind()

    '    myConnection.Close()

    '    'Response.Write("<script>javascript: document.getElementById('scrollmodal').style.display = 'block';<" & "/" & "script>")
    'End Sub

    'Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
    '    If (e.Row.RowType = DataControlRowType.Header) Then
    '        e.Row.Cells(1).Visible = False
    '        e.Row.Cells(4).Visible = False
    '        e.Row.Cells(5).Visible = False
    '        e.Row.Cells(6).Visible = False
    '        e.Row.Cells(7).Visible = False
    '        e.Row.Cells(8).Visible = False
    '        e.Row.Cells(9).Visible = False
    '        e.Row.Cells(10).Visible = False
    '        e.Row.Cells(11).Visible = False
    '        e.Row.Cells(12).Visible = False
    '        e.Row.Cells(13).Visible = False
    '        e.Row.Cells(17).Visible = False
    '        e.Row.Cells(19).Visible = False
    '        e.Row.Cells(20).Visible = False
    '        e.Row.Cells(21).Visible = False
    '        e.Row.Cells(22).Visible = False
    '        e.Row.Cells(23).Visible = False
    '        e.Row.Cells(24).Visible = False
    '        e.Row.Cells(25).Visible = False
    '        e.Row.Cells(26).Visible = False
    '        e.Row.Cells(27).Visible = False
    '        e.Row.Cells(28).Visible = False
    '        e.Row.Cells(29).Visible = False
    '        e.Row.Cells(30).Visible = False
    '        e.Row.Cells(31).Visible = False
    '        e.Row.Cells(32).Visible = False
    '        e.Row.Cells(2).Font.Size = 10
    '        e.Row.Cells(3).Font.Size = 10
    '        e.Row.Cells(14).Font.Size = 10
    '        e.Row.Cells(15).Font.Size = 10
    '        e.Row.Cells(16).Font.Size = 10
    '        e.Row.Cells(18).Font.Size = 10
    '        e.Row.Cells(2).Text = "CLAVE"
    '        e.Row.Cells(3).Text = "ORIGEN"
    '        e.Row.Cells(14).Text = "NOMBRE"
    '        e.Row.Cells(15).Text = "PATERNO"
    '        e.Row.Cells(16).Text = "MATERNO"
    '        e.Row.Cells(18).Text = "SECRETARIA"
    '    End If
    '    If (e.Row.RowType = DataControlRowType.DataRow) Then
    '        e.Row.Cells(1).Visible = False
    '        'e.Row.Cells(3).Visible = False
    '        e.Row.Cells(4).Visible = False
    '        e.Row.Cells(5).Visible = False
    '        e.Row.Cells(6).Visible = False
    '        e.Row.Cells(7).Visible = False
    '        e.Row.Cells(8).Visible = False
    '        e.Row.Cells(9).Visible = False
    '        e.Row.Cells(10).Visible = False
    '        e.Row.Cells(11).Visible = False
    '        e.Row.Cells(12).Visible = False
    '        e.Row.Cells(13).Visible = False
    '        e.Row.Cells(17).Visible = False
    '        e.Row.Cells(19).Visible = False
    '        e.Row.Cells(20).Visible = False
    '        e.Row.Cells(21).Visible = False
    '        e.Row.Cells(22).Visible = False
    '        e.Row.Cells(23).Visible = False
    '        e.Row.Cells(24).Visible = False
    '        e.Row.Cells(25).Visible = False
    '        e.Row.Cells(26).Visible = False
    '        e.Row.Cells(27).Visible = False
    '        e.Row.Cells(28).Visible = False
    '        e.Row.Cells(29).Visible = False
    '        e.Row.Cells(30).Visible = False
    '        e.Row.Cells(31).Visible = False
    '        e.Row.Cells(32).Visible = False
    '        e.Row.Cells(2).Font.Size = 10
    '        e.Row.Cells(3).Font.Size = 10
    '        e.Row.Cells(14).Font.Size = 10
    '        e.Row.Cells(15).Font.Size = 10
    '        e.Row.Cells(16).Font.Size = 10
    '        e.Row.Cells(18).Font.Size = 10
    '    End If
    'End Sub

    'Protected Sub GV_Pasajero_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    '
    '    ' Se obtiene la fila seleccionada del gridview
    '    '
    '    Dim row As GridViewRow = GV_Pasajero.SelectedRow

    '    '
    '    ' Obtengo el id y el nombre  de la entidad que se esta editando
    '    ' en este caso de la entidad Person
    '    '
    '    Txt_Origen.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Origen"))
    '    Txt_Destino.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Destino"))
    '    Txt_DateFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloSalida"))
    '    Txt_HourFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloSalida"))
    '    Txt_DateFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloRegreso"))
    '    Txt_HourFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloRegreso"))
    '    Txt_DetailFly.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_DetalleVuelo"))
    '    Txt_ObPartido.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_ObjPartidista"))
    '    Txt_SolClaveCon.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_ClaveCon"))
    '    Txt_Agencia.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Age_Descripcion"))
    '    Txt_Aerolinea.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Aer_Descripcion"))
    '    Txt_Costo.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Costo"))
    '    Txt_Comentarios.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Comentarios"))
    '    Txt_Archivo.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Archivo"))
    '    Dim TipoReq As Integer = Convert.ToInt16(GV_Pasajero.DataKeys(row.RowIndex).Values("ReT_Clave"))
    '    Dim TipoVue As Integer = Convert.ToInt16(GV_Pasajero.DataKeys(row.RowIndex).Values("VuT_Clave"))

    '    DDL_Req.SelectedValue = TipoReq
    '    DDL_TipoVuelo.SelectedValue = TipoVue

    '    'MsgBox(TipoReq)
    '    'MsgBox(TipoVue)
    'End Sub

    'Sub CleanFields()
    '    Txt_Origen.Text = ""
    '    Txt_Destino.Text = ""
    '    Txt_DateFlyExit.Text = ""
    '    Txt_HourFlyExit.Text = ""
    '    Txt_DateFlyRet.Text = ""
    '    Txt_HourFlyRet.Text = ""
    '    Txt_DetailFly.Text = ""
    '    Txt_ObPartido.Text = ""
    '    DDL_Req.SelectedIndex = 0
    '    DDL_TipoVuelo.SelectedIndex = 0
    '    Txt_Origen.Enabled = False
    '    Txt_Destino.Enabled = False
    '    Txt_DateFlyExit.Enabled = False
    '    Txt_HourFlyExit.Enabled = False
    '    Txt_DateFlyRet.Enabled = False
    '    Txt_HourFlyRet.Enabled = False
    '    Txt_Agencia.Enabled = False
    '    Txt_Aerolinea.Enabled = False
    '    Txt_Costo.Enabled = False
    '    'Txt_Archivo.Enabled = False
    '    ImageButton1.Enabled = False
    '    'Txt_Comentarios.Enabled = False

    '    'Txt_DetailFly.Enabled = False
    '    'Txt_ObPartido.Enabled = False
    '    'DDL_Req.Enabled = False
    '    'DDL_TipoVuelo.Enabled = False
    'End Sub

    'Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs)
    '    Dim vl_Url As String = ""
    '    'Response.AppendHeader("Content-Disposition", Server.MapPath("~/cotizacion/") & Txt_Archivo.Text)
    '    'Response.Redirect("~/cotizacion/" & Txt_Archivo.Text)
    '    vl_Url = "cotizacion/" & Txt_Archivo.Text
    '    Response.Write("<script>window.open('" & vl_Url & "',target='_blank');<" & "/" & "script>")
    'End Sub

    Protected Sub DDL_ProductoTipo_SelectedIndexChanged(sender As Object, e As EventArgs)
        ISP_GetProducto()
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
    <title>App Eventos</title>
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
    <link rel="stylesheet" href="../../assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="../../assets/css/style.css">
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
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppE_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="pe-7s-cash"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="CoordinadorEnlace.aspx" runat="server">VoBo Cordinador de Enlace</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="RevisionEnlace.aspx" runat="server">Revision Area Enlace</asp:HyperLink></li>
                            <% End If %>
                           
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="VoBoSubBase.aspx" runat="server">VoBo SubBase</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod8 = 8 And Vg_Fac8 < 3 Then %>
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppV_SolicitudxRechazar.aspx" runat="server">Mensual por Proveedor</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppV_ReportResumen.aspx" runat="server">Autorizados por Agencia</asp:HyperLink></li>
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
                    <a class="navbar-brand" href="./../portal.aspx"><img src="../../images/logoEventos.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="../../images/logo3.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>

             <div class="top-right">
                <div class="header-menu">   
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="../images/user.png" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="../MiPerfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="../login.aspx" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Logout</a>
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
                        <strong class="card-title">Solicitudes / Nueva</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud</strong>
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
                                                        <label for="input-small" class=" form-control-label">Unidad De Medida</label>
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
                                                            <asp:Button ID="Btn_Aceptar" OnClick ="ISP_SetSolicitudNew" runat="server"  class="btn btn-success btn-sm" Text="Ok" />
                                                        </div>
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
                      <!--
                                <div class="col-sm-6">
                                    Copyright &copy; 2018 Empresa
                                </div>
                                <div class="col-sm-6 text-right">
                                    Designed by <a href="https://colorlib.com">Empresa</a>
                                </div>
                                -->
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
    <script src="../../assets/js/main.js"></script>

    <!--  Chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script>

    <!--Chartist Chart-->
    <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartist-plugin-legend@0.6.2/chartist-plugin-legend.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery.flot@0.8.3/jquery.flot.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-pie@1.0.0/src/jquery.flot.pie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-spline@0.0.1/js/jquery.flot.spline.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/simpleweather@3.1.0/jquery.simpleWeather.min.js"></script>
    <script src="../../assets/js/init/weather-init.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="../../assets/js/init/fullcalendar-init.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#bootstrap-data-table-export').DataTable();
        });
    </script>
</body>
</html>
