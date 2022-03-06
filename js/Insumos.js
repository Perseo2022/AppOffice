

function insumos() {
	var tbody = $('#lista_insumos tbody');
	
	$('#btnAgregar').click(function () {
			if ($('#cantidad').val() == '' ||  $('#SelectInsumos').val() =='') {
		swal("Error!!", "Seleccione la cantidad de insumos!", "error");
			} else {
				$('#lista_insumos').on('click', '.eliminar_insumo', function () {
					$(this).parents('tr').eq(0).remove();
				});
				var fila_nueva = $('<tr></tr>');
				var tdIDInsumo = '<td>' + $('#SelectInsumos').val() + '</td>';
				var tdInsumo = '<td>' + $("#SelectInsumos option:selected").text() + '</td>';
				var tdIdUMedida = '<td>' + $('#SelectUMedida').val() + '</td>';
				var tdUmedida = '<td>' + $("#SelectUMedida option:selected").text() + '</td>';
				var tdCantidad = '<td>' + $('#cantidad').val() + '</td>';
				var btnDelete = '<td>' + '<button type="button" class="btn btn-danger eliminar_insumo"> <i class="fa fa-trash-o" aria-hidden="true"></i></button>' + '</td>';

				fila_nueva.append(tdIDInsumo);
				fila_nueva.append(tdInsumo);
				fila_nueva.append(tdIdUMedida);
				fila_nueva.append(tdUmedida);
				fila_nueva.append(tdCantidad);
				fila_nueva.append(btnDelete);
				tbody.append(fila_nueva);
		}

		$('#lista_insumos tr').each(function () {
			$(this).find("td").eq(2).hide();
			//$('#lista_insumos td:nth-child(1)').hide();
		});
		});

	function tabloToJson() {
		var listIsumos = new Array();
		$("#lista_insumos tbody tr").each(function (index) {
			Insumo_Eventos = {
				IdEvento: 0,
				IdInsumo: $(this).children("td").eq(0).text(),
				UMedida: $(this).children("td").eq(2).text(),
				Cantidad: $(this).children("td").eq(4).text()
			}
			listIsumos.push(Insumo_Eventos);
		});
	//	console.log(listIsumos);

		return listIsumos;
	}

	$("#button_json").click(function () {
		tabloToJson();
	});
}

function loadInsumos() {
	$.ajax({
		type: "POST",
		url: "DatosService.aspx/GetCatalogoTipo",
		data: '',
		//data: ,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {
			
			if (data != null) {
				var listCatalogoDto = data.d;
				$("#SelectTipoInsumos").find('option').remove();
				for (idx in listCatalogoDto) {
					var CatalogoDto = listCatalogoDto[idx];
					$("#SelectTipoInsumos").append("<option value=" + CatalogoDto.ID + ">" + CatalogoDto.Descripcion + "</option>");
				}

			}
		}
	});

	$('#SelectTipoInsumos').on('change', function () {
		//GetInsumos
		$.ajax({
			type: "POST",
			url: "DatosService.aspx/GetInsumos",
			data: JSON.stringify( { IdInsumo: $('#SelectTipoInsumos').val()}),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (data) {
				if (data != null) {
					var listCatalogoDto = data.d;
					$("#SelectInsumos").find('option').remove();
					for (idx in listCatalogoDto) {
						var CatalogoDto = listCatalogoDto[idx];
						$("#SelectInsumos").append("<option value=" + CatalogoDto.ID + ">" + CatalogoDto.Descripcion + "</option>");
					}

				}
			}
			
		});

	});

	$.ajax({
		type: "POST",
		url: "DatosService.aspx/GetCatalogoTipoMontaje",
		data: '',
		//data: ,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {

			if (data != null) {
				var listCatalogoDto = data.d;
				$("#idMontaje").find('option').remove();
				for (idx in listCatalogoDto) {
					var CatalogoDto = listCatalogoDto[idx];
					$("#idMontaje").append("<option value=" + CatalogoDto.ID + ">" + CatalogoDto.Descripcion + "</option>");
				}

			}
		}
	});

	$.ajax({
		type: "POST",
		url: "DatosService.aspx/GetCatalogoLugares",
		data: '',
		//data: ,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {

			if (data != null) {
				var listCatalogoDto = data.d;
				$("#lugar").find('option').remove();
				for (idx in listCatalogoDto) {
					var CatalogoDto = listCatalogoDto[idx];
					$("#lugar").append("<option value=" + CatalogoDto.ID + ">" + CatalogoDto.Descripcion + "</option>");
				}

			}
		}
	});



}

function dowloadReport() {
	$("#btnDescargar").hide();
	$('#btnDescargar').click(function () {
		var listIsumos = new Array();
		$("#lista_insumos tbody tr").each(function (index) {
			Insumo_Eventos = {
				IdEvento: 0,
				IdInsumo: $(this).children("td").eq(0).text(),
				Cantidad: $(this).children("td").eq(2).text()
			}
			listIsumos.push(Insumo_Eventos);
		});

		var Datos = {
			IdArea: $("#DDL_Secretarias").val(),
			FechaInicio: $("#FecInicio").val(),
			FechaFin: $("#FecFin").val(),
			Hora_Inicio: $("#HoraInicio").val(),
			Hora_Fin: $("#HoraFin").val(),
			NumPersonas: $("#NumPersonas").val(),
			Lugar: $("#lugar").val(),
			TipoMontaje: $("#idMontaje").val(),
			NombreEvento: $("#nombreEvento").val(),
			Objetivo: $("#Txt_ObPartido").val(),
			listInsumos: listIsumos
		};


		var jSon = JSON.stringify({ eventoDto: Datos });
		$.ajax({
			type: "POST",
			url: "../ExcelSevice.aspx/DowloadReporte",
			data: jSon,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (data) {
				swal("Listo!!", "Solicitud creada correctamente!", "success");
			},
			error: function (xhr, ajaxOptions, thrownError) {
				swal("Error!!", "Llene los campos requeridos!", "error");
			}

		});
	});
}