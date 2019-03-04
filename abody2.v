module statemachine  (output reg  z, input x,input reset,input clk);
reg currentstate ,nextstate ;
parameter a=1'b1,b=1'b0;



always  @(x or currentstate)
begin
// currentstate=a;

z= currentstate | x ; 
case (currentstate)

a: if(x==0)begin nextstate =b  ; end
else begin nextstate =a ; end

b: if(x==0)begin nextstate =b  ; end
else begin nextstate = a ; end
endcase
end 

always @(posedge clk )
begin
if (reset ==0)  //where reset is active low 
begin nextstate <=a ;	end
else begin currentstate <= nextstate ;	end

end
endmodule
 
module tb ();

reg X,R,Clk;
wire   Z ;

statemachine SM(Z,X,R,Clk);

initial 
begin
$monitor ("%b %b %b %b",X,R,Clk,Z);
X=1;
R=1;
Clk=1;
#5
X=0;
R=1;
Clk=1;

#5
X=1;
R=0;
Clk=1;

#5
X=1;
R=0;
Clk=0;

end
endmodule
