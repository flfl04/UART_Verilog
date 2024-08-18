module SERIALIZER (
					input SER_EN , CLK , RST ,[7:0] P_DATA  ,
					output reg SER_DONE , SERIAL_DATA 
				  );
integer index = 0 ;
always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		SER_DONE <=0 ;
		SERIAL_DATA <= 0;
		index <= 0 ;
	end
	else if (SER_EN)begin
		if (index <= 7) begin
			SERIAL_DATA <= P_DATA [index] ;
			index = index + 1 ;
		end
		if (index == 8) begin
			SER_DONE <= 1 ;
			index = 0 ;
		end
		else begin
			SER_DONE <= 0 ;
		end
	end
end
endmodule