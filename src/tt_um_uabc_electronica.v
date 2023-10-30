`timescale 1ns / 1ps

module tt_um_uabc_electronica #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
    reg reloj;
    reg [25:0] cont = 0;
    
    integer LETRA = 0;
        
    always @(posedge clk) begin
        cont <= cont + 1;
        if(cont == 5000) begin
            cont <= 0;
            reloj <= ~reloj;
            PULSO <= ~PULSO;
        end
    end
    
    always @(posedge reloj) begin
        if (ACTIVAR == 1) begin
            an <= 4'b1110;
            if (LETRA == 16) begin
                LETRA <= 0;
            end else
                LETRA <= LETRA + 1; 
        end else if (ACTIVAR == 0) begin
            an <= 4'b1111; 
            LETRA <= 0;  
        end    
    end
    
    always @(LETRA) begin
        case(LETRA)
            5'b00000: seg = 7'b1111111;
            5'b00001: seg = 7'b1000001; //U
            5'b00010: seg = 7'b0001000; //A
            5'b00011: seg = 7'b0000011; //B
            5'b00100: seg = 7'b1000110; //C
            5'b00101: seg = 7'b0111111; //-
            5'b00110: seg = 7'b0000110; //E
            5'b00111: seg = 7'b1000111; //L 
            5'b01000: seg = 7'b0000110; //E
            5'b01001: seg = 7'b1000110; //C
            5'b01010: seg = 7'b1001110; //T
            5'b01011: seg = 7'b0101111; //R
            5'b01100: seg = 7'b1000000; //O
            5'b01101: seg = 7'b0101011; //N
            5'b01110: seg = 7'b1001111; //I
            5'b01111: seg = 7'b1000110; //C
            5'b10000: seg = 7'b0001000; //A
        endcase
    end
endmodule
