module UART_TX (
					input PAR_EN , DATA_VALID ,PAR_TYP ,CLK ,RST , [7:0] P_DATA ,
					output TX_OUT , BUSY 
				);
wire SER_DONE , SER_EN  , MUX_EN , PAR_BIT , out , SERIAL_DATA;
wire [1:0] MUX_SEL ; 
assign TX_OUT = out ;
// instantiate components
SERIALIZER DUT1 (.*) ;
MUX_4X1 DUT2(.*) ;
PARRTY_CALC DUT3 (.*) ;
FSM DUT4 (.*);
endmodule