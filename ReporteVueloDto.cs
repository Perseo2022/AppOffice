﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de ReporteVueloDto
/// </summary>
public class ReporteVueloDto
{
    public ReporteVueloDto()
    {}
    public string Folio { get; set; }
    public string Fecha { get; set; }
    public string Secretaria { get; set; }
    public string Pasajero { get; set; }
    public string Origen { get; set; }
    public string Destino { get; set; }
    public string FecSalida { get; set; }
    public string FecRegreso { get; set; }
    public string ObjPartidista { get; set; }
    public string FirmaEnlace { get; set; }
    public string FirmaCordAdmon { get; set; }
}