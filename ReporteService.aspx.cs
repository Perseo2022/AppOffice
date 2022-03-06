using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

using NPOI.XSSF.UserModel;

using NPOI.SS.UserModel;
using Newtonsoft.Json;

using System.Configuration;

public partial class ReporteService :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string DownloadReporte(string fecha_Inicio, string fecha_Fin)
    {
        // WriteExcel();
        //Set the File Folder Path.
      //  string path = HttpContext.Current.Server.MapPath("~/App_Data/");
        string path = HttpContext.Current.Server.MapPath("~/Files/");
        CreateReporte(fecha_Inicio, fecha_Fin, path);
       
        //Read the File as Byte Array.
        byte[] bytes = File.ReadAllBytes(path + "Formato_ReporteVuelos_01.xlsx");
        //Convert File to Base64 string and send to Client.
        return Convert.ToBase64String(bytes, 0, bytes.Length);
    }

    private static string CreateReporte(string fecha_Inicio, string fecha_Fin, string dir)
    {
        List<ReporteExcelDto> reporteExcelDtos = getReporteMensual(fecha_Inicio, fecha_Fin);


        DataTable table = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(reporteExcelDtos), (typeof(DataTable)));

        var stream = new MemoryStream();
        var path = dir +"Formato_ReporteVuelos.xlsx";
        var pathSalida =dir  +"Formato_ReporteVuelos_01.xlsx";
        var encabezado = "RESUMEN DE VUELOS AUTORIZADOS POR AGENCIA DEL " + fecha_Inicio + " AL " + fecha_Fin;
        XSSFWorkbook wb1 = null;
        using (var file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite))
        {
            wb1 = new XSSFWorkbook(file);
        }
        List<String> columns = new List<string>();
        int columnIndex = 2;

        /*Border Style*/
        ICellStyle style = wb1.CreateCellStyle();
        //Set border style
        style.BorderBottom = NPOI.SS.UserModel.BorderStyle.Dashed;
        style.BorderLeft = NPOI.SS.UserModel.BorderStyle.Double;
        style.BorderRight = NPOI.SS.UserModel.BorderStyle.Double;

        ICellStyle styledoble = wb1.CreateCellStyle();
        //Set border style
        styledoble.BorderBottom = NPOI.SS.UserModel.BorderStyle.Double;
        styledoble.BorderLeft = NPOI.SS.UserModel.BorderStyle.Double;
        styledoble.BorderRight = NPOI.SS.UserModel.BorderStyle.Double;

        ICellStyle styleBlack = wb1.CreateCellStyle();

        //Set font style
        IFont font = wb1.CreateFont();
        font.FontName = "Calibri";
        font.FontHeightInPoints = 10;
        style.SetFont(font);

        IFont fontBlack = wb1.CreateFont();
        fontBlack.FontName = "Calibri";
        fontBlack.FontHeightInPoints = 10;
        fontBlack.IsBold = true;
        styleBlack.Alignment = HorizontalAlignment.Center;
        styleBlack.SetFont(fontBlack);


        foreach (System.Data.DataColumn column in table.Columns)
        {
            columns.Add(column.ColumnName);
            columnIndex++;
        }
        ISheet excelSheet = wb1.GetSheetAt(0);
        IRow row = excelSheet.CreateRow(0);
        int rowIndex = 8;
        int numVuelos = 1;
        float total = 0;
        //excelSheet.ShiftRows(10, 20, 5,true,false);
        ICell cellEnc = excelSheet.CreateRow(5).CreateCell(1);
        cellEnc.SetCellValue(encabezado);
        cellEnc.CellStyle = styleBlack;

        foreach (DataRow dsrow in table.Rows)
        {
            excelSheet.CopyRow(rowIndex, rowIndex + 1);
            //excelSheet.ShiftRows(rowIndex, rowIndex+2,-1);
            row = excelSheet.CreateRow(rowIndex);
            int cellIndex = 2;
            ICell cellNum = row.CreateCell(1);
            cellNum.CellStyle = style;
            cellNum.SetCellValue(numVuelos);
            foreach (String col in columns)
            {

                ICell cell = row.CreateCell(cellIndex);
                cell.CellStyle = style;
                if (col == "Total")
                {
                    total += Convert.ToSingle(dsrow[col]);
                    cell.SetCellValue(Convert.ToSingle(dsrow[col]));
                }
                else
                {
                    cell.SetCellValue(dsrow[col].ToString());
                }
                cellIndex++;
            }

            numVuelos++;
            rowIndex++;
        }
        row = excelSheet.GetRow(rowIndex);
        ICell cellTotal = row.GetCell(11);
        //cellTotal.CellStyle = styledoble;
        cellTotal.SetCellValue(total);

        /*Totales*/
        rowIndex = rowIndex + 7;
        DataTable tableTotale = getTotales(fecha_Inicio, fecha_Fin);
        columns = new List<string>();
        foreach (System.Data.DataColumn column in tableTotale.Columns)
        {
            columns.Add(column.ColumnName);
            columnIndex++;
        }

        float totalCoste = 0;
       ICell cellTotalCoste= excelSheet.GetRow(rowIndex + 3).GetCell(4);
        foreach (DataRow dsrow in tableTotale.Rows)
        {
            int cellIdx = 2;
            row = excelSheet.GetRow(rowIndex);
            foreach (String col in columns)
            {
                if (col != "Age_Clave")
                {
                    ICell cell = row.GetCell(cellIdx);
                    cell.CellStyle = style;
                    cell.SetCellValue(dsrow[col].ToString());
                    cellIdx++;
                }
                if (col == "TotalCosto") {
                    totalCoste += Convert.ToSingle(dsrow[col]);
                }
            }
            rowIndex++;
        }
        cellTotalCoste.SetCellValue(totalCoste);


        using (var file2 = new FileStream(pathSalida, FileMode.Create, FileAccess.ReadWrite))
        {
            wb1.Write(file2);
            file2.Close();
        }

        return "";
    }

    public static List<ReporteExcelDto> getReporteMensual(string fecha_Inicio, string fecha_Fin)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))

        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetReporteByFEcha"))
            {
                
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@Fecha_Inicio", SqlDbType.VarChar);
                param.Value = fecha_Inicio;
                param = cmd.Parameters.Add("@Fecha_Fin", SqlDbType.VarChar);
                param.Value = fecha_Fin;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<ReporteExcelDto> listaVuelos = new List<ReporteExcelDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        ReporteExcelDto vuelo = new ReporteExcelDto();
                        vuelo.FechaSolicitud = ((DateTime)dtRow["Fecha_Solicitud"]).ToString("dd/MM/yyyy");
                        vuelo.Nombre = (string)dtRow["Nombre"];
                        vuelo.Apellidos = (string)dtRow["Apellidos"];
                        vuelo.vuelo = (string)dtRow["Vuelo"];
                        vuelo.Periodo = (string)dtRow["Periodo"];
                        vuelo.Horario = (string)dtRow["Horario"];
                        vuelo.Destino = (string)dtRow["Destino"];
                        vuelo.Aerolinea = (string)dtRow["Aerolinea"];
                        vuelo.Reservacion = (string)dtRow["Reservacion"];
                        vuelo.Total = Convert.ToSingle(dtRow["Total"]);
                        vuelo.Area = (string)dtRow["Area"];
                        vuelo.Agencia = (string)dtRow["Agencia"];
                        vuelo.Clve = (string)dtRow["Cve"];

                        listaVuelos.Add(vuelo);

                    }
                    return listaVuelos;
                }
            }
        }

    }
    public static DataTable getTotales(string fecha_Inicio, string fecha_Fin)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))

        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetReporteGen"))
            {

                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                SqlParameter param;
                param = cmd.Parameters.Add("@Fecha_Inicio", SqlDbType.VarChar);
                param.Value = fecha_Inicio;
                param = cmd.Parameters.Add("@Fecha_Fin", SqlDbType.VarChar);
                param.Value = fecha_Fin;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

    }
}
