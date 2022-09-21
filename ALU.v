module ALU #(
    parameter DATA_BUS = 8,
    parameter OP_BUS = 6
)
(
    input   wire                clock,
    input   wire [DATA_BUS-1:0] op_a_bus,
    input   wire [DATA_BUS-1:0] op_b_bus,
    input   wire [OP_BUS-1:0]   op_code_bus,
    input   wire [2:0]          enables,
    output  wire [DATA_BUS:0]   result_bus
);

localparam ADD_OP   = 6'h20;
localparam SUB_OP   = 6'h22;
localparam AND_OP   = 6'h24;
localparam OR_OP    = 6'h25;
localparam XOR_OP   = 6'h26;
localparam NOR_OP   = 6'h27;
localparam SRA_OP   = 6'h3;
localparam SRL_OP   = 6'h2;


reg [DATA_BUS-1:0]  op_a;
reg [DATA_BUS-1:0]  op_b;
reg [OP_BUS-1:0]    op_code;
reg [DATA_BUS:0]    result;

always @(enables[0])
begin
    if (enables[0] == 1)
        op_a <= op_a_bus;
end

always @(enables[1])
begin
    if (enables[1] == 1)
        op_b <= op_b_bus;
end

always @(enables[2])
begin
    if (enables[2] == 1)
        op_code <= op_code_bus;
end

always @(posedge clock)
begin
    /*
        if (enables[0] == 1)
            op_a <= op_a_bus;
        if (enables[1] == 1)
            op_b <= op_b_bus;
        if (enables[2] == 1)
            op_code <= op_code_bus;
    */
    case(op_code)
        ADD_OP : result = op_a + op_b;
        SUB_OP : result = {1'b0, op_a - op_b};
        AND_OP : result = op_a & op_b;
        OR_OP  : result = op_a | op_b;
        XOR_OP : result = op_a ^ op_b;
        NOR_OP : result = {1'b0, ~{op_a | op_b}};
        SRA_OP : result = {op_a[DATA_BUS-1], op_a[DATA_BUS-1 : 1]};
        SRL_OP : result = op_a >> 1;
        default: result = {DATA_BUS+1'bx};
    endcase
end
    
assign result_bus = result;    

endmodule