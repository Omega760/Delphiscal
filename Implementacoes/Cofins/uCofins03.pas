unit uCofins03;

interface

uses uICofins03;

type
  TCofins03 = class(TInterfacedObject, ICofins03)
  private
  FQuantidadeTributada: currency;
  FValorUnidadeTributada: currency;
  public
    constructor Create(_quantidadeTributada,
                       _valorPorUnidadeTributada: currency);
    function ValorCofins: currency;

  end;

implementation
uses acbrutil.Math;
{ TIpi50Especifico }

constructor TCofins03.Create(_quantidadeTributada,
                          _valorPorUnidadeTributada: currency);
begin
 FQuantidadeTributada := _quantidadeTributada;
 FValorUnidadeTributada := _valorPorUnidadeTributada;

end;

function TCofins03.ValorCofins: currency;
begin
  result := RoundABNT((FQuantidadeTributada * FValorUnidadeTributada),2);
end;
end.
