module FSM (
    input wire SER_DONE, PAR_EN, DATA_VALID, CLK, RST,
    output reg SER_EN, BUSY, MUX_EN,
    output reg [1:0] MUX_SEL
);

// State declaration using parameter
parameter IDLE      = 3'b000,
          START_BIT = 3'b001,
          SERIAL    = 3'b010,
          PARITY    = 3'b011,
          STOP_BIT  = 3'b100;

reg [2:0] CS, NS, Counter;
reg END_SERIAL;

// Next State Logic 
always @(*) begin
    case (CS)
        IDLE     :  if (DATA_VALID) 
                        NS = START_BIT;
                    else 
                        NS = IDLE;

        START_BIT:  NS = SERIAL;

        SERIAL   :  if (END_SERIAL) begin
                        if (PAR_EN)
                            NS = PARITY;
                        else
                            NS = STOP_BIT; 
                    end else 
                        NS = SERIAL;
                    
        PARITY   :  NS = STOP_BIT;
                    
        STOP_BIT  : if (DATA_VALID) 
                        NS = START_BIT;
                    else 
                        NS = IDLE;
    endcase
end

// Output Logic 
always @(CS) begin
    BUSY   = 0;
    SER_EN = 0;
    MUX_EN = 0;
    MUX_SEL = 0;

    case (CS)
        START_BIT:  begin
                        BUSY   = 1;
                        SER_EN = 1;
                        MUX_EN = 1;
                        MUX_SEL = 0;
                    end
        SERIAL   :  begin
                        BUSY   = 1;
                        SER_EN = 1;
                        MUX_EN = 1;
                        MUX_SEL = 1;
                    end
        PARITY   :  begin
                        BUSY   = 1;
                        SER_EN = 0;
                        MUX_EN = 1;
                        MUX_SEL = 2;
                    end
        STOP_BIT :  begin
                        BUSY   = 1;
                        SER_EN = 0;
                        MUX_EN = 1;
                        MUX_SEL = 3;
                    end
    endcase
end

// State Memory 
always @ (posedge CLK or negedge RST) begin
    if (~RST) begin
        CS <= IDLE;
        Counter <= 0;
        END_SERIAL <= 0;
    end
    else begin
        CS <= NS;    
        if (CS == SERIAL)
            Counter <= Counter + 1;
        else 
            Counter <= 0;
        
        if (Counter == 3'b110) begin
        	END_SERIAL <= 1;
        	SER_EN <= 0;
        end 
        else 
            END_SERIAL <= 0;
    end
end

endmodule
