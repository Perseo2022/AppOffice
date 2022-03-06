

    function descarga(folio) {
        $.ajax({
            type: "POST",
            url: "ExcelSevice.aspx/getNombreFile",
            data: '{folio: "' + folio+ '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                //Convert Base64 string to Byte Array.
                DownloadFile(folio, r.d);
            }
        });
    }

    function DownloadFile(folio,fileName) {
        // fileName = 'ReporteEvento_' + $("#claveRespuesta").val()+'.xlsx';

        var Datos = { Folio: folio, Fecha: "20/01/2021", Pasajero: "Pasajero: Adrian Lopez de Leon", Vuelo: "Vuelo: " + $("#DDL_TipoVuelo").val(), Destino: "Destino: " + $("#Txt_Destino").val(), FecSalida: "Fecha de Salida: " + $("#Txt_DateFlyExit").val(), FecRegreso: "Fecha de Regreso: " + $("#Txt_DateFlyRet").val() };
        var jSon = JSON.stringify({ jsonData: Datos });
        $.ajax({
            type: "POST",
            url: "ExcelSevice.aspx/DescargaReporteVuelos",
            data: jSon,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                //Convert Base64 string to Byte Array.
                var bytes = Base64ToBytes(r.d);

                //Convert Byte Array to BLOB.
                var blob = new Blob([bytes], { type: "application/octetstream" });

                //Check the Browser type and download the File.
                var isIE = false || !!document.documentMode;
                if (isIE) {
                    window.navigator.msSaveBlob(blob, fileName);
                } else {
                    var url = window.URL || window.webkitURL;
                    link = url.createObjectURL(blob);
                    var a = $("<a />");
                    a.attr("download", fileName);
                    a.attr("href", link);
                    $("body").append(a);
                    a[0].click();
                    $("body").remove(a);
                }
            }
        });

    };
    function Base64ToBytes(base64) {
        var s = window.atob(base64);
        var bytes = new Uint8Array(s.length);
        for (var i = 0; i < s.length; i++) {
            bytes[i] = s.charCodeAt(i);
        }
        return bytes;
    };
