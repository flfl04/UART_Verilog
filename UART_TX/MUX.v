module MUX_4X1 (
				input  SERIAL_DATA , PAR_BIT , MUX_EN ,[1:0] MUX_SEL ,
				output reg out 
				);
reg port1 , port4 ;
always @(*) begin
	port1 = 1'b0;
	port4 = 1'b1;
	if (MUX_EN) begin
		if (MUX_SEL == 2'b00) out = port1 ;
		else if (MUX_SEL == 2'b01) out = SERIAL_DATA ;
		else if (MUX_SEL == 2'b10) out = PAR_BIT ;
		else out = port4 ;
	end
	else 
		out = 1'b1 ;
end
endmodule