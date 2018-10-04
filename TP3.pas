program tp3(input,output);  										{Direccion de los archivos: C:\Tp3\TP3.pas}
uses crt;
type
    pagoypeso= array[1..2,1..2] of Real;
    cantidadrepet = array[1..4,1..50] of Integer;

	gimnasio = record 												{Declaracion de los registros para los archivos}
		nombre,direccion: String[30];
		valor_cuota: Real;
		valor_nutricionista: Real;
		valor_personal_trainer: Real;
	end;

	actividades = record
		codigo_actividad: Integer;
		descripcion_actividad: String[30];
	end;

	dias_y_horarios = record
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
		pago_en_pesos_y_peso_actual: pagoypeso;
	end;

	rutinas_x_clientes = record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad_repeticiones: cantidadrepet;
		borrado_logico: Boolean;
	end;

    g = file of gimnasio;
    a = file of actividades;
    d = file of dias_y_horarios;
    e = file of ejercicios_x_rutina;
    c = file of clientes;
    r = file of rutinas_x_clientes;

var
	gim:g;
	act:a;
	dia_y_hora:d;
	ejexrut:e;
	cli:c;
	rutxcli:r;

function dicotomica(a:c;b:string): integer;
var
sup,inf,med:integer;
band:boolean;
begin
     sup:=filesize(a)-1;
     inf:=0;
     band:=false;
     while (band= false) and (inf <= sup) do
     begin
          med:= (inf+sup)div 2;
          seek(cli,med);
          read(c,clientes);
          if clientes.dni <> b then
             begin
                  if clientes.dni > b then
                     begin
                          sup:=med-1
                     end
                  else
                     begin
                          inf:=med-1
                     end;
             end
          else
              begin
                   band:=true
              end;
     if clientes.dni = b then
        begin
              dicotomica:=0
        end
     else
         begin
              dicotomica:=1
         end;

end;


procedure busqueda_cliente();
var
   dni:string;

begin
    read(cli,clientes);
	write('Ingrese el DNI del cliente: ');
	readln(dni);
    a:= dictomica(dni);
    if a = 0 then
       begin
            write('Ingrese DNI: ');
            readln(dni);
            write('Ingrese Nombre y apellido: ');
            readln(nom_ape);
            write('Prefiere rutinas? (S/N)');
            readln(rut);
            write('Prefiere nutricionista? (S/N));
            readln(nutri);
            write('Preferie Personal Trainer? (S/N)');
            readln(pt);
            for 1 to 2 do
            begin
                 writeln('Ingrese el pago en pesos del año en orden, 1 pago: Enero, 12 pago: Diciembre: ')
            end;

       end
end;








procedure menu;  {Menu principal}
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
	assign (cli,'C:\Tp3\Clientes.dat');
	rewrite(cli);
    reset(cli);
    menu;
    readkey
end.
