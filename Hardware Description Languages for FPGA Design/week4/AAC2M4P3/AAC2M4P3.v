module FSM( input In1, RST, CLK, output reg Out1); 
  integer state; 
  parameter a=0; 
  parameter b=1; 
  parameter c=2; 
  always @ (posedge CLK) begin
    if (RST==1) begin state = a; Out1 = 0; end 
    else 
    begin 
      case (state) 
        a: 
        if (In1==1) 
        begin 
          state = b; 
          Out1=0; 
        end 
        else 
        begin 
          state = a; 
          Out1=0; 
        end 
        
        b: 
        if (In1==0) 
        begin 
          state = c; 
          Out1=0; 
        end 
        else 
        begin 
          state = b; 
          Out1=0; 
        end 
        
        c: 
        if (In1==0) 
        begin 
          state = a; Out1=1; 
        end 
        else 
        begin 
          state = c; Out1=0; 
        end 
        default: state = a; 
      endcase 
    end 
  end 
endmodule
