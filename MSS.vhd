library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity MSS is
	port(clk, resetn, WriteData,limite, may: in std_logic;
		enContador, resetContador, escrituraRAM, cargarSemilla, cargamay: out std_logic);
end MSS;

architecture comportamiento of MSS is
type estado is (A, B, C, D, E, F, G,H,I);
signal y : estado;

begin
			process(clk, resetn)
			begin
				if resetn='0' then y<=A;
				elsif (clk' event and clk='1') then
				case y is
					when A => if WriteData='1' then y<=B;
								 else y<=A; end if;
					when B => if WriteData='0' then y<=C;
					          else y<=B; end if;
					when C => y<=D;
					when D => if limite='1' then y<=E;
								 else y<=D; end if;
					-- carga de datos hacia la RAM finaliza
					when E => y<=F;
					when F => if may='1' then y<=	G;
								 else y<=H; end if;
								 					when G => if limite='1' then y<=I;
					           else y<=H; end if;
					when H => y<=F;
					when I => y<=A;
				end case;
		end if;
	end process;
	
	process(y) --codificaciónn de salidas
	begin
        enContador<='0'; resetContador<='1'; escrituraRAM<='0'; cargarSemilla<='0'; cargamay<='0';
		 case y is
		when A =>
		when B =>
		when C => cargarSemilla<='1'; 
		when D => enContador<='1'; cargarSemilla<='0'; escrituraRAM<='1';
		when E => escrituraRAM<='0'; resetContador<='0'; enContador<='0';
		when F => resetContador<='1'; 
		when G => cargamay<='1';
		when H => enContador<='1';
		When I=> enContador<='0'; resetContador <='0';
		
	end case;
end process;
end comportamiento;

		
								 
