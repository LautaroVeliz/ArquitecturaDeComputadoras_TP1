module ALU_sim();
//Local params
localparam LOCAL_DATA_BUS = 8;
localparam LOCAL_OP_BUS = 6;
// Outputs
wire [LOCAL_DATA_BUS:0]   result_bus_out;
// Inputs
reg                      i_clock;
reg [LOCAL_DATA_BUS-1:0] i_op_a_bus;
reg [LOCAL_DATA_BUS-1:0] i_op_b_bus;
reg [LOCAL_OP_BUS-1:0]   i_op_code_bus;
reg [2:0]                i_enables;

initial begin
$dumpfile("dump.vcd"); $dumpvars;
i_clock = 1'b1 ;
i_enables = 3'b0;
i_op_a_bus = 8'h55;
i_op_b_bus = 8'ha7;
i_op_code_bus = 6'h20;
#5
i_enables = 3'b111;
#3
i_op_b_bus = 8'hd4;
#3
i_enables = 3'b0;
#3
i_enables = 3'b010;
#3
i_enables = 3'b0;
i_op_code_bus = 6'h22;
#3
i_enables = 3'b100;
i_op_b_bus = 8'h15;
#3
i_enables = 3'b010;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h24;
i_enables = 3'b100;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h25;
i_enables = 3'b100;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h26;
i_enables = 3'b100;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h27;
i_enables = 3'b100;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h2;
i_enables = 3'b100;
#3
i_enables = 3'b0;
#3
i_op_code_bus = 6'h3;
i_op_a_bus = 8'h88;
i_enables = 3'b101;
#6
$finish ;
end
always begin
#1
i_clock = ~i_clock ;
end

ALU #(
    .DATA_BUS (LOCAL_DATA_BUS),
    .OP_BUS (LOCAL_OP_BUS)
) 
alu_01 (
    .clock (i_clock),
    .op_a_bus (i_op_a_bus),
    .op_b_bus (i_op_b_bus),
    .op_code_bus (i_op_code_bus),
    .enables (i_enables),
    .result_bus (result_bus_out)
);
endmodule
