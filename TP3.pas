program tp3(input,output);  {Direccion de los archivos: C:\Tp-pascal\TP3.pas}
uses crt;
type
    pago_en_pesos_y_peso_actual = array[1..2,1..2] of Real;
    cantidad_repeticiones = array[1..4,1..50] of Integer;

	gimnasio = record 								{Declaracion de los registros para los archivos}
		nombre,direccion: String[30];
		valor_cuota: Real;
		valor_nutricionista: Real;
		valor_personal_trainer: Real;
	end;

	actividades = record
		codigo_actividad: Integer;
		descripcion_actividad: String[30];
	end;

	dias_y_actividades = record
		dia: Integer;
		hora: String[5];
		codigo_actividad: Integer;
	end;

	ejercicios_x_rutina = record
		codigo_ejercicio: Integer;
		descripcion_rutina: String[30];
	end;

	clientes = record
		dni: Integer;
		nombre_y_apellido: String[30];
		rutina_sn: Char;
		nutri_sn: Char;
		personal_sn: Char;
		pago_en_pesos_y_peso_actual: pago_en_pesos_y_peso_actual;
	end;

	rutinasxclientes = record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad_repeticiones: cantidad_repeticiones;
		borrado_logico: Boolean;
	end;
var
	repet: cantidad_repeticiones;
	pagoypeso: pago_en_pesos_y_peso_actual;

procedure menu;
var
   op:Integer;
begin
    writeln('Menu de opciones');
    writeln('1) ABM');
    writeln('2) Clientes');
    writeln('3) Rutinas por clientes');
    writeln('4) Listado de dias y horarios');
    writeln('5) Recaudacion');
    writeln('6) Reiniciar (blanqueo)');

    repeat
       readln(op);
    until (op >=1) and (op <=6);

    while op <> 7 do
      begin
          case op of
             1: writeln('Texto de prueba');
             2: writeln('Texto de prueba');
             3: writeln('Texto de prueba');
             4: writeln('Texto de prueba');
             5: writeln('Texto de prueba');
             6: writeln('Texto de prueba');
          end;

          repeat
             readln(op);
          until (op >=1) and (op <= 6);
      end;
end;

begin
	{Menu/Programa princial}
    menu;
    readkey
end.
