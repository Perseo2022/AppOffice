 using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Web.Services;


using NPOI.SS.UserModel;
using NPOI.HSSF.UserModel;
using NPOI.XSSF.UserModel;
using iTextSharp.text.pdf;
using iTextSharp.text;


using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public partial class ExcelSevice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string DownloadFile(string fileName)
    {
       // WriteExcel();
        //Set the File Folder Path.
        string path = HttpContext.Current.Server.MapPath("~/App_Data/");
        Console.WriteLine(fileName);
        //Read the File as Byte Array.
        byte[] bytes = File.ReadAllBytes(path + fileName);
        //Convert File to Base64 string and send to Client.
        return Convert.ToBase64String(bytes, 0, bytes.Length);
    }

    [WebMethod]
    public static string CreateReporteEvent(int idEvento)
    {
        DataTable table = getReporteEvento(idEvento);
        string pathServer = HttpContext.Current.Server.MapPath("~/Files/");

        var stream = new MemoryStream();
        var path = pathServer +"Reporte_Evento.xlsx";
        var pathSalida = pathServer + "Reporte_Evento01.xlsx";
        XSSFWorkbook wb1 = null;
        using (var file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite))
        {
            wb1 = new XSSFWorkbook(file);
        }
        DataRow dsrow = table.Rows[0];

        /*Border Style*/
        ICellStyle style = wb1.CreateCellStyle();
        //Set border style
        style.BorderBottom = BorderStyle.Dashed;
        style.BorderLeft = BorderStyle.Double;
        style.BorderRight = BorderStyle.Double;

        ISheet excelSheet = wb1.GetSheetAt(0);

        DateTime hoy = DateTime.Today;

        excelSheet.GetRow(4).GetCell(9).SetCellValue(hoy.Day);
        excelSheet.GetRow(4).GetCell(10).SetCellValue(hoy.Month);
        excelSheet.GetRow(4).GetCell(11).SetCellValue(hoy.Year);

        int CveUptal = (int)dsrow["IUptal_Clave"];
        if (CveUptal.Equals(197))
        {
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: Unidad de Servicios Básicos");
        }
        else
        {
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: " + (string)dsrow["Sec_Descripcion"]);
        }
        excelSheet.GetRow(1).GetCell(9).SetCellValue("Folio: " + (string)dsrow["Cod_Solicitud"]);
        //excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: " + (string)dsrow["Sec_Descripcion"]);
        excelSheet.GetRow(5).GetCell(0).SetCellValue("Nombre del evento: " + (string)dsrow["Nombre_evento"]);
        excelSheet.GetRow(6).GetCell(0).SetCellValue("Fecha (s): " + ((DateTime)dsrow["Fecha_Inicio"]).ToString("dd/MM/yyyy") + "-" + ((DateTime)dsrow["Fecha_Fin"]).ToString("dd/MM/yyyy"));
        excelSheet.GetRow(6).GetCell(6).SetCellValue("Hora Inicio: " + (string)dsrow["Hora_Inicio"]);
        excelSheet.GetRow(6).GetCell(9).SetCellValue("Hora Fin: " + (string)dsrow["Hora_Fin"]);
        excelSheet.GetRow(45).GetCell(0).SetCellValue("OBJETO PARTIDISTA: " + (string)dsrow["Objetivo"]);

        DataTable InsumosEvento = getGetInsumosEvent(idEvento);
        int idxRow = 22;
        foreach (DataRow producto in InsumosEvento.Rows)
        {
            excelSheet.GetRow(idxRow).GetCell(0).SetCellValue((int)producto["Id_Insumo"]);
            excelSheet.GetRow(idxRow).GetCell(2).SetCellValue((string)producto["Prod_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(8).SetCellValue((string)producto["UnM_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(10).SetCellValue((int)producto["Cantidad"]);
            idxRow++;
        }
        excelSheet.GetRow(59).GetCell(2).SetCellValue((string)dsrow["Enlace"]);
        excelSheet.GetRow(55).GetCell(0).SetCellValue((string)dsrow["CordAdmon"]);
        excelSheet.GetRow(55).GetCell(7).SetCellValue((string)dsrow["Titular_Area"]);

        //excelSheet.GetRow(45).GetCell(0).SetCellValue((string)dsrow["Enlace"]);
        //excelSheet.GetRow(57).GetCell(0).SetCellValue((string)dsrow["CordAdmon"]);
        //excelSheet.GetRow(57).GetCell(4).SetCellValue((string)dsrow["Titular_Area"]);


        using (var file2 = new FileStream(pathSalida, FileMode.Create, FileAccess.ReadWrite))
        {
            wb1.Write(file2);
            file2.Close();
        }
        
         byte[] bytes = File.ReadAllBytes(pathSalida);
        return Convert.ToBase64String(bytes, 0, bytes.Length);
    }

    public static DataTable getReporteEvento(int Id_Evento)
    {
        //llama a la base de datos en especifico
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        //se realiza la conexión a la base de datos
        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            //Se llama el comando a ejecutar en este caso la consulta, SP, View
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetReportEvent"))
            {
                //
                cmd.Connection = cn;
                //Se identifica el tipo de comando que se ejecuta en este caso es un SP
                cmd.CommandType = CommandType.StoredProcedure;
               //SE abre la conexión
                cn.Open();
                //Se declaracio de variables autilizan en el SP
                SqlParameter param;
                //Asigancion de nombre a las variables al del SP indicanto tipo de dato
                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                //Signa el valor obtenido del front
                param.Value = Id_Evento;
                //Se Adapta el valor del comando en este caso el cmd que ya trae la consulta
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    //Genera un instancia de tipo DateTable 
                    DataTable dt = new DataTable();
                    //Lena la instancia con el resultado de la consulta
                    da.Fill(dt);
                    //Devuelve la tabla
                    return dt;
                }
            }
        }

    }

    public static DataTable getGetInsumosEvent(int idEvento)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;

        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetInsumosEvent"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                param.Value = idEvento;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    return dt;
                }
            }
        }
    }

    [WebMethod]
    public static string getNombreFile(string folio)
    {
        ReporteVueloDto reporteVueloDto = GetDEtalleReporte(folio);
        //return reporteVueloDto.Pasajero + reporteVueloDto.Folio+".xlsx";
        return reporteVueloDto.Pasajero + reporteVueloDto.Folio + ".xlsx";
    }

        [WebMethod]
    public static string DescargaReporteVuelos(Datos jsonData)
    {
            ReporteVueloDto reporteVueloDto = GetDEtalleReporte(jsonData.Folio);
            string pathServer = HttpContext.Current.Server.MapPath("~/Files/");

        //DataTable table = getReporteInsumo(clave);
        var stream = new MemoryStream();
        var path = pathServer + "Reporte_Vuelos.xlsx";
        var pathSalida = pathServer + "ReporteVuelos_01.xlsx";
        XSSFWorkbook wb1 = null;
        using (var file = new FileStream(@path, (FileMode)FileAccess.ReadWrite))
        {
            wb1 = new XSSFWorkbook(file);
        }
      
       
        /*Border Style*/
        ICellStyle style = wb1.CreateCellStyle();
        //Set border style
        style.BorderBottom = BorderStyle.Dashed;
        style.BorderLeft = BorderStyle.Double;
        style.BorderRight = BorderStyle.Double;

        ISheet excelSheet = wb1.GetSheetAt(0);
        DateTime hoy = DateTime.Today;

        String VariableDondeRecibesLaFecha = reporteVueloDto.Fecha;
        char delimitador = '/';
        string[] valores = VariableDondeRecibesLaFecha.Split(delimitador);

        //GEVS
        string d = valores[0];
        string m = valores[1];
        string y = valores[2];

        excelSheet.GetRow(4).GetCell(9).SetCellValue(d);
        excelSheet.GetRow(4).GetCell(10).SetCellValue(m);
        excelSheet.GetRow(4).GetCell(11).SetCellValue(y);

        if (reporteVueloDto.CveUptal.Equals(197))
        {
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: Unidad de Servicios Básicos");
        }
        else
        {
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: " + reporteVueloDto.Secretaria);
        }

        excelSheet.GetRow(1).GetCell(9).SetCellValue("Folio: " + reporteVueloDto.Folio);
        excelSheet.GetRow(34).GetCell(6).SetCellValue("OBJETO PARTIDISTA    : " + reporteVueloDto.ObjPartidista);
        // excelSheet.GetRow(34).GetCell(6).SetCellValue("Fecha (s): " + ((DateTime)dsrow["Fecha_Inicio"]).ToString("dd/MM/yyyy") + "-" + ((DateTime)dsrow["Fecha_Fin"]).ToString("dd/MM/yyyy"));

        //  excelSheet.GetRow(6).GetCell(9).SetCellValue("Hora Fin: " + (string)dsrow["Hora_Fin"]);
        // excelSheet.GetRow(45).GetCell(0).SetCellValue("OBJETO PARTIDISTA: " + (string)dsrow["Objetivo"]);

        string vacio = "";

        excelSheet.GetRow(9).GetCell(2).SetCellValue(" Tipo vuelo: " + reporteVueloDto.Tipo_Vuelo);
        excelSheet.GetRow(10).GetCell(2).SetCellValue(" Pasajero: " +  reporteVueloDto.Pasajero);
        excelSheet.GetRow(11).GetCell(2).SetCellValue(" Origen: " +  reporteVueloDto.Origen);
        excelSheet.GetRow(12).GetCell(2).SetCellValue(" Destino: " +  reporteVueloDto.Destino);
        excelSheet.GetRow(13).GetCell(2).SetCellValue(" Fecha de Salida: " +  reporteVueloDto.FecSalida);
        excelSheet.GetRow(14).GetCell(2).SetCellValue(" Hora de Salida: " + reporteVueloDto.HoraOrigen);
        if(!reporteVueloDto.FecRegreso.TrimStart().Equals(vacio)) {
        excelSheet.GetRow(15).GetCell(2).SetCellValue(" Fecha de Regreso: " +  reporteVueloDto.FecRegreso);
        excelSheet.GetRow(16).GetCell(2).SetCellValue(" Hora de Regreso: " + reporteVueloDto.HoraDestino);


        }
        excelSheet.GetRow(17).GetCell(2).SetCellValue(" Detalle: " + reporteVueloDto.Detalle);

       



        /*Border Style*/
        ICellStyle stylefirma = wb1.CreateCellStyle();
        //Set border style
        stylefirma.BorderBottom = BorderStyle.Medium;

        excelSheet.GetRow(45).GetCell(0).SetCellValue( reporteVueloDto.FirmaEnlace);
        excelSheet.GetRow(57).GetCell(0).SetCellValue("" +  reporteVueloDto.FirmaCordAdmon);
        excelSheet.GetRow(57).GetCell(4).SetCellValue("" + reporteVueloDto.Titular_Area);
        excelSheet.GetRow(58).GetCell(0).SetCellValue("Coordinador (a) Administrativo (a) / Director (a)");

       // excelSheet.GetRow(45).GetCell(0).CellStyle = stylefirma;
       // excelSheet.GetRow(45).GetCell(3).CellStyle = stylefirma;


        using (var file2 = new FileStream(pathSalida, FileMode.Create, FileAccess.ReadWrite))
        {
            wb1.Write(file2);
            file2.Close();
        }

        byte[] bytes = File.ReadAllBytes(pathSalida);
        //Convert File to Base64 string and send to Client.
        return Convert.ToBase64String(bytes, 0, bytes.Length); 
    }


    [WebMethod]
    public static string DescargaReporteInsumo(string clave)
    {
        string pathServer = HttpContext.Current.Server.MapPath("~/Files/");
        DataTable table = getReporteInsumo(clave);
        var stream = new MemoryStream();
        var path = pathServer +"Reporte_Insumo_1.xlsx";
        var pathSalida = pathServer +"ReporteInsumo_01.xlsx";
        XSSFWorkbook wb1 = null;
        using (var file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite))
        {
            wb1 = new XSSFWorkbook(file);
        }
        DataRow dsrow = table.Rows[0];
        DataTable productos = getReporteInsumoProductos((int)dsrow["ISol_Clave"]);
        /*Border Style*/
        ICellStyle style = wb1.CreateCellStyle();
        //Set border style
        style.BorderBottom = BorderStyle.Dashed;
        style.BorderLeft = BorderStyle.Double;
        style.BorderRight = BorderStyle.Double;

        ISheet excelSheet = wb1.GetSheetAt(0);
         

        String VariableDondeRecibesLaFecha = ((string)dsrow["Fecha_Solicitud"]);
        int CveUptal = (int)dsrow["IUptal_Clave"];
        char delimitador = '-';
        string[] valores = VariableDondeRecibesLaFecha.Split(delimitador);
        //GEVS
        string y = valores[0];
        string m = valores[1];
        string d = valores[2];

        excelSheet.GetRow(4).GetCell(9).SetCellValue(d);
        excelSheet.GetRow(4).GetCell(10).SetCellValue(m);
        excelSheet.GetRow(4).GetCell(11).SetCellValue(y);

        if (CveUptal.Equals(197))
        { 
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante:  Unidad de Servicios Básicos");
        }
        else
        {
            excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: " + (string)dsrow["Sec_Descripcion"]);
        }
        excelSheet.GetRow(1).GetCell(7).SetCellValue("U. Ptal.: " + (int)dsrow["IUptal_Clave"]);
        excelSheet.GetRow(1).GetCell(9).SetCellValue("Folio: " + (string)dsrow["ISol_ClavePres"]);
        excelSheet.GetRow(4).GetCell(0).SetCellValue("Tel.: " + (string)dsrow["ISol_UbiTelefono"] + "                           Ext.: " + (string)dsrow["ISol_UbiExtension"]);
        excelSheet.GetRow(4).GetCell(5).SetCellValue("Edificio: " + (string)dsrow["ISol_UbiEdificio"]);
        excelSheet.GetRow(4).GetCell(7).SetCellValue("Piso: " + (string)dsrow["ISol_UbiPiso"]);
        excelSheet.GetRow(34).GetCell(6).SetCellValue("OBJETO PARTIDISTA    : " + (string)dsrow["ISol_ObjPart"]);
        // excelSheet.GetRow(34).GetCell(6).SetCellValue("Fecha (s): " + ((DateTime)dsrow["Fecha_Inicio"]).ToString("dd/MM/yyyy") + "-" + ((DateTime)dsrow["Fecha_Fin"]).ToString("dd/MM/yyyy"));

        //  excelSheet.GetRow(6).GetCell(9).SetCellValue("Hora Fin: " + (string)dsrow["Hora_Fin"]);
        // excelSheet.GetRow(45).GetCell(0).SetCellValue("OBJETO PARTIDISTA: " + (string)dsrow["Objetivo"]);

        int idxRow = 9;
        foreach (DataRow producto in productos.Rows)
        {
            excelSheet.GetRow(idxRow).GetCell(0).SetCellValue((string)producto["CveProd"]);
            excelSheet.GetRow(idxRow).GetCell(2).SetCellValue((string)producto["Prod_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(8).SetCellValue((string)producto["UnM_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(10).SetCellValue((int)producto["Ins_Cantidad"]);
            idxRow++;
        }

        excelSheet.GetRow(45).GetCell(0).SetCellValue((string)dsrow["Enlace"]);
        excelSheet.GetRow(57).GetCell(0).SetCellValue((string)dsrow["CordAdmon"]);
        excelSheet.GetRow(57).GetCell(4).SetCellValue((string)dsrow["Titular_Area"]);

        using (var file2 = new FileStream(pathSalida, FileMode.Create, FileAccess.ReadWrite))
        {
            wb1.Write(file2);
            file2.Close();
        }

        byte[] bytes = File.ReadAllBytes(pathSalida);
        //Convert File to Base64 string and send to Client.
        return Convert.ToBase64String(bytes, 0, bytes.Length); ;
    }

    [WebMethod]
    public static string DescargaReportecompras(string clave)
    {
        string pathServer = HttpContext.Current.Server.MapPath("~/Files/");
        DataTable table = getReporteCompras(clave);
        var stream = new MemoryStream();
        var path = pathServer + "Reporte_Compras.xlsx";
        var pathSalida = pathServer + "Reportecompras_01.xlsx";
        XSSFWorkbook wb1 = null;
        using (var file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite))
        {
            wb1 = new XSSFWorkbook(file);
        }
        DataRow dsrow = table.Rows[0];
        DataTable productos = getReporteComprasProductos((int)dsrow["CSol_clave"]);
        /*Border Style*/
        ICellStyle style = wb1.CreateCellStyle();
        //Set border style
        style.BorderBottom = BorderStyle.Dashed;
        style.BorderLeft = BorderStyle.Double;
        style.BorderRight = BorderStyle.Double;

        ISheet excelSheet = wb1.GetSheetAt(0);
        DateTime hoy = DateTime.Today;

        excelSheet.GetRow(4).GetCell(9).SetCellValue(hoy.Day);
        excelSheet.GetRow(4).GetCell(10).SetCellValue(hoy.Month);
        excelSheet.GetRow(4).GetCell(11).SetCellValue(hoy.Year);

        excelSheet.GetRow(1).GetCell(1).SetCellValue("Área Solicitante: " + (string)dsrow["Sec_Descripcion"]);
        excelSheet.GetRow(1).GetCell(9).SetCellValue("Folio: " + (string)dsrow["CSol_ClavePres"]);
        //  excelSheet.GetRow(34).GetCell(6).SetCellValue("OBJETO PARTIDISTA    : " + (string)dsrow["ISol_ObjPart"]);
        // excelSheet.GetRow(34).GetCell(6).SetCellValue("Fecha (s): " + ((DateTime)dsrow["Fecha_Inicio"]).ToString("dd/MM/yyyy") + "-" + ((DateTime)dsrow["Fecha_Fin"]).ToString("dd/MM/yyyy"));

        //  excelSheet.GetRow(6).GetCell(9).SetCellValue("Hora Fin: " + (string)dsrow["Hora_Fin"]);
        // excelSheet.GetRow(45).GetCell(0).SetCellValue("OBJETO PARTIDISTA: " + (string)dsrow["Objetivo"]);

        int idxRow = 9;
        foreach (DataRow producto in productos.Rows)
        {
            excelSheet.GetRow(idxRow).GetCell(0).SetCellValue((string)producto["CveProd"]);
            excelSheet.GetRow(idxRow).GetCell(2).SetCellValue((string)producto["Prod_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(8).SetCellValue((string)producto["UnM_Descripcion"]);
            excelSheet.GetRow(idxRow).GetCell(10).SetCellValue((int)producto["Com_Cantidad"]);
            idxRow++;
        }

        excelSheet.GetRow(45).GetCell(0).SetCellValue((string)dsrow["Enlace"]);
        excelSheet.GetRow(57).GetCell(0).SetCellValue((string)dsrow["CordAdmon"]);
        excelSheet.GetRow(57).GetCell(4).SetCellValue((string)dsrow["Titular_Area"]);

        using (var file2 = new FileStream(pathSalida, FileMode.Create, FileAccess.ReadWrite))
        {
            wb1.Write(file2);
            file2.Close();
        }

        byte[] bytes = File.ReadAllBytes(pathSalida);
        //Convert File to Base64 string and send to Client.
        return Convert.ToBase64String(bytes, 0, bytes.Length); ;
    }

    [WebMethod]
    public static string CreatePDF(Datos jsonData)
    {
        // WriteExcel();
        //Set the File Folder Path.
        string path = HttpContext.Current.Server.MapPath("~/Files/");
        string recibo = System.Web.Hosting.HostingEnvironment.MapPath("~/Files/PlantillaModificado.pdf");
        Console.WriteLine(jsonData);
       string nameRecibo = EditPdf(path, jsonData);
        byte[] bytes = File.ReadAllBytes(path + "Reporte.xlsx");
        //Convert File to Base64 string and send to Client.
        string patht = HttpContext.Current.Request.Url.AbsoluteUri.Replace(HttpContext.Current.Request.Url.PathAndQuery, "/") + "/Files/"+ nameRecibo;

        return patht;
        //return Convert.ToBase64String(bytes, 0, bytes.Length);
    }

    [WebMethod]
    public static string CreatePDFInsumos(Datos jsonData)
    {
        // WriteExcel();
        //Set the File Folder Path.
        string path = HttpContext.Current.Server.MapPath("~/Files/");
        string recibo = System.Web.Hosting.HostingEnvironment.MapPath("~/Files/PlantillaModificado.pdf");
        Console.WriteLine(jsonData);
        string nameRecibo = EditPdfInsumos(path, jsonData);
        byte[] bytes = File.ReadAllBytes(path + "Reporte.xlsx");
        //Convert File to Base64 string and send to Client.
        string patht = HttpContext.Current.Request.Url.AbsoluteUri.Replace(HttpContext.Current.Request.Url.PathAndQuery, "/") + "/Files/" + nameRecibo;

        return patht;
        //return Convert.ToBase64String(bytes, 0, bytes.Length);

    }


    public static string EditPdf(string path, Datos jsonData)
    {

        ReporteVueloDto reporteVueloDto = GetDEtalleReporte(jsonData.Folio);
        //rutas de nuestros pdf
        string nameFinal = "Recibo_" + jsonData.Folio + ".pdf";
        string pathPDF = path + "Plantilla.pdf";
        string pathPDF2 = path +  nameFinal;

        //Objeto para leer el pdf original
        PdfReader oReader = new PdfReader(pathPDF);
        //Objeto que tiene el tamaño de nuestro documento
        Rectangle oSize = oReader.GetPageSizeWithRotation(1);
        //documento de itextsharp para realizar el trabajo asignandole el tamaño del original
        Document oDocument = new Document(oSize);

        // Creamos el objeto en el cual haremos la inserción
        FileStream oFS = new FileStream(pathPDF2, FileMode.Create, FileAccess.Write);
        PdfWriter oWriter = PdfWriter.GetInstance(oDocument, oFS);
        oDocument.Open();
        //El contenido del pdf, aqui se hace la escritura del contenido
        PdfContentByte oPDF = oWriter.DirectContent;
        PdfImportedPage page = oWriter.GetImportedPage(oReader, 1);
        oPDF.AddTemplate(page, 0, 0);
        //Propiedades de nuestra fuente a insertar
        BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        oPDF.SetColorFill(BaseColor.BLACK);
        oPDF.SetFontAndSize(bf, 8);
        //Se abre el flujo para escribir el texto
        oPDF.BeginText();
    //asignamos el texto

        string pasajero = "Pasajero:" + reporteVueloDto.Pasajero;
        string vuelo = "Vuelo:" + reporteVueloDto.Origen;
        string destino = "Destino:" + reporteVueloDto.Destino;
        string FechaSalida = "Fecha de Salida:" +reporteVueloDto.FecSalida;
        string FechaRegreso = "Fecha de Regreso:" +reporteVueloDto.FecRegreso;

        string Folio = reporteVueloDto.Folio;
        string Fecha = reporteVueloDto.Fecha;
        string iDate = Fecha;
        DateTime oDate = DateTime.ParseExact(iDate, "dd/MM/yyyy", null);
        /*cambios secretaria y ojetivo*/
        string secretaria = reporteVueloDto.Secretaria;
        string objetivo = reporteVueloDto.ObjPartidista;
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, secretaria, 136, oSize.Height - 60, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, objetivo + "", 400, oSize.Height - 470, 0);
        /*cambios secretaria y ojetivo*/
        //  DateTime oDate = Convert.ToDateTime(iDate);
        // Le damos posición y rotación al texto
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, pasajero, 130, oSize.Height - 210, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, vuelo, 130, oSize.Height - 220, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, destino, 130, oSize.Height - 230, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, FechaSalida, 130, oSize.Height - 240, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, FechaRegreso, 130, oSize.Height - 250, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, Folio, 532, oSize.Height - 58, 0);

        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Day + "", 502, oSize.Height - 98, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Month + "", 532, oSize.Height - 98, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Year + "", 562, oSize.Height - 98, 0);
        oPDF.EndText();

        oDocument.Close();
        oFS.Close();
        oWriter.Close();
        oReader.Close();

        return nameFinal;
    }

    public static string EditPdfInsumos(string path, Datos jsonData)
    {

        //rutas de nuestros pdf
        string nameFinal = "ReciboInsumo_" + jsonData.Folio + ".pdf";
        string pathPDF = path + "Plantilla.pdf";
        string pathPDF2 = path + nameFinal;

        //Objeto para leer el pdf original
        PdfReader oReader = new PdfReader(pathPDF);
        //Objeto que tiene el tamaño de nuestro documento
        Rectangle oSize = oReader.GetPageSizeWithRotation(1);
        //documento de itextsharp para realizar el trabajo asignandole el tamaño del original
        Document oDocument = new Document(oSize);

        // Creamos el objeto en el cual haremos la inserción
        FileStream oFS = new FileStream(pathPDF2, FileMode.Create, FileAccess.Write);
        PdfWriter oWriter = PdfWriter.GetInstance(oDocument, oFS);
        oDocument.Open();
        //El contenido del pdf, aqui se hace la escritura del contenido
        PdfContentByte oPDF = oWriter.DirectContent;
        PdfImportedPage page = oWriter.GetImportedPage(oReader, 1);
        oPDF.AddTemplate(page, 0, 0);
        //Propiedades de nuestra fuente a insertar
        BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        oPDF.SetColorFill(BaseColor.BLACK);
        oPDF.SetFontAndSize(bf, 8);
        //Se abre el flujo para escribir el texto
        oPDF.BeginText();
        //asignamos el texto

        string pasajero = "Pasajero:" + jsonData.Pasajero;
        //string vuelo = "Vuelo:" + jsonData.Origen;
        string destino = "Destino:" + jsonData.Destino;
        string FechaSalida = "Fecha de Salida:" + jsonData.FecSalida;
        string FechaRegreso = "Fecha de Regreso:" + jsonData.FecRegreso;

        string Folio = jsonData.Folio;
        string Fecha = jsonData.Fecha;
        string iDate = Fecha;
        DateTime oDate = DateTime.ParseExact(iDate, "dd/MM/yyyy", null);
        /*cambios secretaria y ojetivo*/
        string secretaria = jsonData.Secretaria;
       // string objetivo = jsonData.ObjPartidista;
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, secretaria, 136, oSize.Height - 60, 0);
       // oPDF.ShowTextAligned(Element.ALIGN_LEFT, objetivo + "", 400, oSize.Height - 470, 0);
        /*cambios secretaria y ojetivo*/
        //  DateTime oDate = Convert.ToDateTime(iDate);
        // Le damos posición y rotación al texto
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, pasajero, 130, oSize.Height - 210, 0);
       // oPDF.ShowTextAligned(Element.ALIGN_LEFT, vuelo, 130, oSize.Height - 220, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, destino, 130, oSize.Height - 230, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, FechaSalida, 130, oSize.Height - 240, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, FechaRegreso, 130, oSize.Height - 250, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, Folio, 532, oSize.Height - 58, 0);

        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Day + "", 502, oSize.Height - 98, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Month + "", 532, oSize.Height - 98, 0);
        oPDF.ShowTextAligned(Element.ALIGN_LEFT, oDate.Year + "", 562, oSize.Height - 98, 0);
        oPDF.EndText();

        oDocument.Close();
        oFS.Close();
        oWriter.Close();
        oReader.Close();

        return nameFinal;
    }

    private static void WriteExcel()
    {

        string path = HttpContext.Current.Server.MapPath("~/Files/");
        var stream = new MemoryStream();

        using (FileStream fileStream = new FileStream(path + "Reporte.xlsx", FileMode.Create, FileAccess.Write))
        {


            IWorkbook workbook = new XSSFWorkbook();
            HSSFFont myFont = (HSSFFont)workbook.CreateFont();
            myFont.FontHeightInPoints = 11;
            myFont.FontName = "Tahoma";
            // Defining a border
            HSSFCellStyle borderedCellStyle = (HSSFCellStyle)workbook.CreateCellStyle();
            borderedCellStyle.SetFont(myFont);
            
            borderedCellStyle.VerticalAlignment = VerticalAlignment.Center;
            ISheet Sheet = workbook.CreateSheet("Report");
            //Creat The Headers of the excel
            IRow HeaderRow = Sheet.CreateRow(0);

            workbook.Write(fileStream);

            fileStream.Close();
        }
    }
    private void CreateCell(IRow CurrentRow, int CellIndex, string Value, HSSFCellStyle Style)
    {
        ICell Cell = CurrentRow.CreateCell(CellIndex);
        Cell.SetCellValue(Value);
        Cell.CellStyle = Style;
    }

    [WebMethod]
    public static string DowloadReporte(EventosDto eventoDto) {


       
        string path = HttpContext.Current.Server.MapPath("~/Files/");
        var stream = new MemoryStream();


        HSSFWorkbook hssfwb;
        using (FileStream file = new FileStream(path + "FormatoEvento.xlsx", FileMode.Open, FileAccess.Read))
        {
            hssfwb = new HSSFWorkbook(file);
            file.Close();
        }

        ISheet sheet = hssfwb.GetSheetAt(0);
        IRow row = sheet.GetRow(0);

        sheet.CreateRow(row.LastCellNum);
        ICell cell = row.CreateCell(row.LastCellNum);
        cell.SetCellValue(eventoDto.NombreEvento);

        for (int i = 0; i < row.LastCellNum; i++)
        {
            Console.WriteLine(row.GetCell(i));
        }

        using (FileStream file = new FileStream(path + "FormatoEvento.xlsx", FileMode.Open, FileAccess.Write))
        {
            

            hssfwb.Write(file);
            file.Close();
        }

        return "";
    }

    private static ReporteVueloDto GetDEtalleReporte(string clave)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString)) 
        {
            using (SqlCommand cmd = new SqlCommand("[AppE_SPGetDetalleReporte]"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramID = new SqlParameter();
                paramID.ParameterName = "@SOL_CLAVE";
                paramID.Value = clave;

                cmd.Parameters.Add(paramID);

                cn.Open();
                
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<EventosDto> details = new List<EventosDto>();
                    ReporteVueloDto reporteVueloDto = new ReporteVueloDto();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        reporteVueloDto.Folio = (string)dtRow["Sol_Clave"];
                        //GEVS
                        reporteVueloDto.Fecha = ((DateTime)dtRow["Fecha_Solicitud"]).ToString("dd/MM/yyyy");
                        reporteVueloDto.Pasajero = (string)dtRow["Nombre"];
                        reporteVueloDto.Secretaria = (string)dtRow["secretaria"];
                        reporteVueloDto.Origen = (string)dtRow["Sol_Origen"];
                        reporteVueloDto.Destino = (string)dtRow["Sol_Destino"];
                        reporteVueloDto.ObjPartidista = (string)dtRow["Sol_ObjPartidista"];
                        reporteVueloDto.FecSalida = (string)dtRow["Sol_FechaVueloSalida"];
                        reporteVueloDto.HoraOrigen =(string)dtRow["Sol_HoraVueloSalida"]; 
                        reporteVueloDto.FecRegreso = (string)dtRow["Sol_FechaVueloRegreso"];
                        reporteVueloDto.HoraDestino = (string)dtRow["Sol_HoraVueloRegreso"];
                        reporteVueloDto.Detalle = (string)dtRow["Sol_DetalleVuelo"];
                        reporteVueloDto.Tipo_Vuelo = (string)dtRow["VuT_Descripcion"];
                        reporteVueloDto.Titular_Area = (string)dtRow["Titular_Area"];
                        reporteVueloDto.CveUptal = (int)dtRow["IUptal_Clave"];
                        //VuT_Descripcion

                        reporteVueloDto.FirmaEnlace = (string)dtRow["Enlace"];
                        reporteVueloDto.FirmaCordAdmon = (string)dtRow["CordAdmon"];
                    }
                    return reporteVueloDto;
                }
            }
        }
    }
    public static DataTable getReporteInsumo(string codeEvento)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;

        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.AppI_SPGetReporteInsumo"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@ISol_ClavePres", SqlDbType.VarChar);
                param.Value = codeEvento;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    return dt;
                }
            }
        }

    }

    public static DataTable getReporteCompras(string codeEvento)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;

        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.AppC_SPGetReporteCompras"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@CSol_ClavePres", SqlDbType.VarChar);
                param.Value = codeEvento;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    return dt;
                }
            }
        }

    }

    public static DataTable getReporteInsumoProductos(int idSolicitud)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.AppI_SPGetInsumos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@ISol_Clave", SqlDbType.Int);
                param.Value = idSolicitud;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    return dt;
                }
            }
        }
    }   
    public static DataTable getReporteComprasProductos(int idSolicitud)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["AppV"].ConnectionString;
        using (SqlConnection cn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.AppC_SPGetCompras"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@CSol_Clave", SqlDbType.Int);
                param.Value = idSolicitud;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    cn.Close();
                    return dt;
                }
            }
        }
    }

}


