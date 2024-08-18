module PARRTY_CALC (
						input   PAR_TYP , [7:0] P_DATA ,
						output PAR_BIT
					);
assign PAR_BIT = (PAR_TYP == 1'b0)? ^(P_DATA)  : ~ ( ^(P_DATA));
endmodule