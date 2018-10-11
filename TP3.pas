program tp3(input,output);  {Direccion de los archivos: C:\Tp-pascal\TP3.pas}
uses crt, sysutils;
type
    pp = array[1..12,1..2] of Real;
    cantidad_repeticiones = array[1..4,1..50] of Integer;

	gimnasio = record 								{Declaracion de los registros para los archivos}
		nombre: String[30];
        direccion: String[30];
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
		dni: string[8];
		nombre_y_apellido: String[30];
		rutina_sn: Char;
		nutri_sn: Char;
		personal_sn: Char;
		pago_en_pesos_y_peso_actual:pp;
	end;

	rutinas_x_clientes = record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad_repeticiones: cantidad_repeticiones;
		borrado_logico: Boolean;
	end;

var
    {registros}
    g:gimnasio;
    a:actividades;
    dyhreg:dias_y_horarios;
    exrreg:ejercicios_x_rutina;
    c:clientes;
    rxcreg:rutinas_x_clientes;
    busqueda:integer;

    {archivos}
    gim: file of gimnasio;
    act: file of actividades;
    dyh: file of dias_y_horarios;
    exr: file of ejercicios_x_rutina;
    cli: file of clientes;
    rxc: file of rutinas_x_clientes;

function dicotomica(a:string): integer;
var
sup,med,inf:integer;
band:boolean;
begin
     if filesize(cli) > 0 then
     begin
          sup:=filesize(cli)-1;
          inf:=0;
          band:=false;
          while (band=false) and (inf<=sup) do
                begin
                med:=(sup+inf) div 2;
                read(cli,c);
                readkey;
                seek(cli,med);
                if a = c.dni then
                begin
                     band:=true;
                     dicotomica:=1;
                end                                       {1 lo encontro}
                else
                    if a < c.dni then
                    begin
                         sup:=med-1;
                    end
                    else
                    begin
                         inf:=med-1;
                    end;
                end;
          if a <> c.dni then
          begin
               dicotomica:=0;
          end;
     if filesize(cli)=0 then;
     begin
          dicotomica:=0;
     end;
end;
end;

procedure ABM;
var
    op: Integer;
begin

    clrscr;
    writeln('Menu de ABM');
    writeln('¿Que archivo desea utilizar?');
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
                   writeln('1) Dar de alta nuevo cliente');
                   writeln('2) Modificar datos del cliente');
                   repeat
                        readln(op);
                   until (op >= 1) and (op <= 2);
                   if op = 1 then
                      begin
                         writeln('Ingrese el nombre');
                         readln(g.nombre);
                         writeln('Ingrese la direccion');
                         readln(g.direccion);
                         writeln('Ingrese el valor de la cuota');
                         repeat
                               readln(g.valor_cuota);
                         until (g.valor_cuota > 0);
                         writeln('Ingrese el valor del nutricionista');
                         repeat
                               readln(g.valor_nutricionista);
                         until g.valor_nutricionista > 0;
                         writeln('Ingrese el valor del personal trainer');
                         repeat
                               readln(g.valor_personal_trainer);
                         until g.valor_nutricionista > 0;

                         write(gim,g);

                      end
                   else
                      begin  {terminar}
                         writeln('Ingrese un nuevo valor para el valor de la cuota');
                         writeln('Ingrese un nuevo valor para el valor del nutricionista');
                         writeln('Ingrese un nuevo valor para el valor del personal trainer');
                      end;
                end;

             2: begin
                   writeln('Ingrese el codigo de la actividad');
                   repeat
                   readln(a.codigo_actividad);
                   until a.codigo_actividad > 0;
                   writeln('Ingrese la descripcion de la actividad');
                   readln(a.descripcion_actividad);

                   write(act,a);
                end;

             3:  begin
                    writeln('Ingrese el dia');
                    repeat
                          readln(dyhreg.dia);
                    until dyhreg.dia > 0;
                    writeln('Ingrese la hora');
                    readln(dyhreg.hora);
                    writeln('Ingrese el codigo de la actividad');
                    repeat
                          readln(dyhreg.codigo_actividad);
                    until dyhreg.codigo_actividad > 0;

                    write(dyh,dyhreg);
                 end;
             4:  begin
                    writeln('Ingrese el codigo de ejercicio');
                    repeat
                          readln(exrreg.codigo_ejercicio);
                    until exrreg.codigo_ejercicio > 0;
                    writeln('Ingrese la descripcion de la rutina');
                    readln(exrreg.descripcion_rutina);

                    write(exr,exrreg);
                end;
          end;

          repeat
             readln(op);
          until (op >=1) and (op <= 4);
      end;
end;

{============================================================================= CLIENTES ============================================================================}

procedure CLIENT();
var
   yy,mm,dd:word;
   mes,anio:integer;
   pago:real;
   deuda:char;
   dni:string[8];
begin
     clrscr;
     writeln('Ingrese el DNI: ');
     readln(dni);
     writeln('Filesize: ', filesize(cli));
     busqueda:=dicotomica(dni);
     writeln('Dicotomica: ', busqueda);
     readkey;
     if busqueda = 1 then                                {Si la busqueda dicotomica devuelve 1, quiere decir que se encontro el cliente}
     begin
          decodedate(date,yy,mm,dd);
          mes:=mm;
          anio:=yy;
          if c.pago_en_pesos_y_peso_actual[mes,1] = 0 then                   {Si esta condicion es verdadera, significa que debe este mes}
          begin
               writeln('Usted debe el mes actual');                            {Se le consultan datos nuevamente y se verifica si desea pagar el mes o no}
               writeln('Desea solicitar una rutina (S/N): ');
               repeat
                     readln(c.rutina_sn);
               until (c.rutina_sn='s') or (c.rutina_sn='n');
               writeln('Desea solicitar un Personal Trainer? (S/N): ');
               repeat
                     readln(c.personal_sn);
               until (c.personal_sn='s') or (c.personal_sn='n');
               writeln('Desea pagar el mes actual? (S/N)');
               repeat
                     readln(deuda);
               until (deuda='s') or (deuda='n');
               if deuda = 's' then
               begin
                    clrscr;
                    writeln('Ingrese el monto del pago: ');
                    repeat
                          readln(pago);
                    until pago>0;
                    c.pago_en_pesos_y_peso_actual[mes,1]:=pago;
                    writeln('El pago fue registrado con exito');
                    readkey;
               end;

          end;
     end;
     if busqueda=0 then
     begin
          {$I-}
          clrscr;
          writeln('El cliente con DNI ( ',dni,' ) no pertenece a nuestros clientes');
          writeln();
          writeln('Para continuar, Detalle los siguientes datos a continuacion: ');
          writeln('Ingrese el nombre y el apellido: ');
          readln(c.nombre_y_apellido);
          writeln('Desea solicitar una rutina (S/N): ');
          repeat
                readln(c.rutina_sn);
          until (c.rutina_sn='s') or (c.rutina_sn='n');
          if c.rutina_sn='s' then
          begin
               rxcreg.mes:=mes;
               rxcreg.anio:=anio;
               rxcreg.dni:=dni;
          end;
          writeln('Desea solicitar un Personal Trainer? (S/N): ');
          repeat
                readln(c.personal_sn);
          until (c.personal_sn='s') or (c.personal_sn='n');
          writeln('Ingrese el monto del pago: ');
          repeat
                readln(pago);
          until pago>0;
          c.pago_en_pesos_y_peso_actual[mes,1]:=pago;
          writeln('El pago fue registrado con exito');
          rxcreg.borrado_logico:=false;
          c.dni:=dni;
          readkey;
     end;
     write(cli,c);
     write(rxc,rxcreg);
end;

{============================================================================= RUTINAS ============================================================================}

procedure RUTINAS();
var
dni:string[8];
mm,yy,dd,mes,anio:word;
busqueda:integer;
begin
     decodedate(date,yy,mm,dd);
     mes:=mm;
     anio:=yy;
     write('Ingrese DNI del cliente: ');
     readln(dni);
     busqueda:=dicotomica(dni);
     if (busqueda=1) and (rxcreg.borrado_logico=false) then
     begin
          write('Ingrese el mes correspondiente');
          readln(mes);
          write('Ingrese el año correspondiente: ');
          readln(anio);
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
             1: ABM();
             2: CLIENT();
             3: RUTINAS();
             4: writeln('Texto de prueba');
             5: writeln('Texto de prueba');
             6: writeln('Texto de prueba');
          end;
          clrscr;
          writeln('Menu de opciones');
          writeln('1) ABM');
          writeln('2) Clientes');
          writeln('3) Rutinas por clientes');
          writeln('4) Listado de dias y horarios');
          writeln('5) Recaudacion');
          writeln('6) Reiniciar (blanqueo)');

          repeat
             readln(op);
          until (op >=1) and (op <= 6);
      end;
end;

begin
     assign(gim,'C:\TP3\gimnasio.dat');
     {$I-}
     reset(gim);
     if ioresult = 2 then
        rewrite(gim);
     {$I+}

     assign(act,'C:\TP3\actividades.dat');
     {$I-}
     reset(act);
     if ioresult = 2 then
        rewrite(act);
     {$I+}

     assign(dyh,'C:\TP3\dias_y_horarios.dat');
     {$I-}
     reset(dyh);
     if ioresult = 2 then
        rewrite(dyh);
     {$I+}

     assign(exr,'C:\TP3\ejercicios_x_rutinas.dat');
     {$I-}
     reset(exr);
     if ioresult = 2 then
        rewrite(exr);
     {$I+}

     assign(cli,'C:\TP3\clientes.dat');
     {$I-}
     reset(cli);
     if ioresult = 2 then
        rewrite(cli);
     {$I+}

     assign(rxc,'C:\TP3\rutinas_x_clientes.dat');
     {$I-}
     reset(rxc);
     if ioresult = 2 then
        rewrite(rxc);
     {$I+}
	{Menu/Programa princial}
    menu;
    readkey
end.
