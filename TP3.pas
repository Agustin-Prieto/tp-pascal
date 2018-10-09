program tp3(input,output);  										{Direccion de los archivos: C:\Tp3\TP3.pas}
uses crt, sysutils;
type
    pagoypeso= array[1..2,1..12] of Real;
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
		dni: string[20];
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


function dicotomica(a:string[20]): integer;    {Busqueda dicotomica, si el resultado devuevle un "1" quiere decir que no se encontro, en cambio
                                                si es "0", significa que si encontro el dni buscado}

var
   b:clientes;
   sup,inf,med:integer;
   band:boolean;
begin
     sup:=filesize(cli)-1;
     inf:=0;
     band:=false;
     while (band= false) and (inf <= sup) do
     begin
          med:= (inf+sup)div 2;
          seek(cli,med);
          read(cli,b);
          if a <> b.dni then
             begin
                  if b.dni > a then
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
     if a = b.dni then
        begin
              dicotomica:=0
        end
     else
         begin
              dicotomica:=1
         end;

end;
end;


procedure busqueda_cliente();                                       {Se busca el cliente mediante una funcion dicotomica}
var
   p:pagoypeso;
   r:rutinas_x_clientes;
   clien:clientes;
   dni:string[20];
   nom_ape:string[30];
   rut,nutri,pt:char;
   dico,a,b,mes,anio:integer;
   k:boolean;

begin
    read(cli,clien);
	write('Ingrese el DNI del cliente: ');
	readln(dni);
    dico:= dicotomica(dni);
    if dico = 0 then                                                     {Cuando no lo encuentra, se le da de alta y se le preguntan los campos del registro}
       begin
            write('Ingrese DNI: ');
            readln(dni);
            write(clien.dni,dni);
            write('Ingrese Nombre y apellido: ');
            readln(nom_ape);
            write(clien.nombre_y_apellido,nom_ape);
            write('Prefiere rutinas? (S/N)');
            readln(rut);
            if rut = 's' then
            begin
                 write(clien.rutina_sn,rut);
                 write(r.dni,dni);
                 writeln('Ingrese el mes');
                 readln(mes);
                 writeln('Ingrese año');
                 readln(anio);
                 write(r.mes,mes);
                 write(r.anio,anio);
                 k:=false;
                 write(r.borrado_logico,k);
            end;
            write('Prefiere nutricionista? (S/N)): ');
            readln(nutri);
            write(clien.nutri_sn,nutri);
            write('Preferie Personal Trainer? (S/N)');
            readln(pt);
            write(clien.personal_sn,pt);
       end;
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
procedure ABM;
var
    op: Integer;

    dir_gim: string;    {Variables con direcciones de archivos}
    dir_act: string;
    dir_d_y_h: string;
    dir_eje_x_rut: string;
    dir_cli: string;
    dir_rut_x_cli: string;
begin
    dir_gim:= 'C:\tp-pascal\gimnasio.dat';
    dir_act:= 'C:\tp-pascal\actividades.dat';
    dir_d_y_h:= 'C:\tp-pascal\diasyhorarios.dat';
    dir_eje_x_rut:= 'C:\tp-pascal\ejerciciosxrutina.dat';
    dir_cli:= 'C:\tp-pascal\clientes.dat';
    dir_rut_x_cli:= 'C:\tp-pascal\rutinasxclientes.dat';

    clrscr;
    writeln('Menu de ABM');
    writeln('¿Que archivo quiere crear?');
    writeln('1) Gimnasio');
    writeln('2) Actividades');
    writeln('3) Dias y Horarios');
    writeln('4) Ejercicios por Rutinas');

    repeat
       readln(op);
    until (op >=1) and (op <=4);

    while op <> 5 do
      begin
          case op of
             1: begin
                   writeln('¿Quiere crear/abrir el archivo o quiere modificar algun campo?');
                   writeln('1) Crear/Abrir Archivo');
                   writeln('2) Modificar un campo');
                   repeat
                        readln(op);
                   until (op >= 1) and (op <= 2);
                   if op = 1 then
                      begin
                         assign(gim,dir_gim);
                         {$I-}
                         reset(gim);
                         if ioresult = 2 then
                            rewrite(act);
                         {$I+}
                         {writeln('Ingrese el nombre');
                         read(g.nombre); }
                         writeln('Ingrese la direccion');
                         read(g.direccion);
                         writeln('Ingrese el valor de la cuota');
                         read(g.valor_cuota);
                         writeln('Ingrese el valor del nutricionista');
                         read(g.valor_nutricionista);
                         writeln('Ingrese el valor del personal trainer');
                         read(g.valor_personal_trainer);
                      end
                   else
                      begin
                         writeln('Ingrese un nuevo valor para el valor de la cuota');
                         writeln('Ingrese un nuevo valor para el valor del nutricionista');
                         writeln('Ingrese un nuevo valor para el valor del personal trainer');
                      end;
                end;

             2: begin
                   assign(act,dir_act);
                   {$I-}
                   reset(act);
                   If ioresult =2 then
                      rewrite(act);
                   {$I+}

                   writeln('Ingrese el codigo de la actividad');
                   read(a.codigo_actividad);
                   writeln('Ingrese la descripcion de la actividad');
                   read(a.descripcion_actividad);
                end;

             3:  begin
                    assign(d_y_h,dir_d_y_h);
                    {$I-}
                    reset(d_y_h);
                    If ioresult =2 then
                       rewrite(d_y_h);
                    {$I+}

                    writeln('Ingrese el dia');
                    read(dyh.dia);
                    writeln('Ingrese la hora');
                    read(dyh.hora);
                    writeln('Ingrese el codigo de la actividad');
                    read(dyh.codigo_actividad);
                 end;
             4:  begin
                    assign(rut_x_cli,dir_rut_x_cli);
                    {$I-}
                    reset(rut_x_cli);
                    If ioresult =2 then
                       rewrite(rut_x_cli);
                    {$I+}

                    writeln('Ingrese el codigo de ejercicio');
                    read(exr.codigo_ejercicio);
                    writeln('Ingrese la descripcion de la rutina');
                    read(exr.descripcion_rutina);
                end;
          end;

          repeat
             readln(op);
          until (op >=1) and (op <= 4);
      end;
end;

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
             1: ABM;
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
    reset(cli);}
    menu;
    readkey
end.
