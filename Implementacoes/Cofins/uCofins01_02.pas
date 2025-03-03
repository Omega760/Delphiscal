unit uCofins01_02;

interface
uses uBaseCofins, uICofins01_02;

type
  TCofins01_02 = class(TInterfacedObject, ICofins01_02)
  private
    FBaseCofins: TBaseCofins;
    FAliquotaCofins: currency;
  public

    constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto,
                       _aliquotaCofins: currency);
    destructor Destroy; override;
    function BaseCofins: currency;
    function ValorCofins: currency;


  end;

implementation
uses acbrutil.Math;

{ TPis01_02 }

function TCofins01_02.BaseCofins: currency;
begin
  result := FBaseCofins.CalcularBaseCofins;
end;

constructor TCofins01_02.Create(_valorProduto,
                             _valorFrete,
                             _valorSeguro,
                             _despesasAcessorias,
                             _valorDesconto,
                             _aliquotaCofins: currency);
begin

 FBaseCofins := TBaseCofins.Create(_valorProduto,
                             _valorFrete,
                             _valorSeguro,
                             _despesasAcessorias,
                             _valorDesconto);

 FAliquotaCofins := _aliquotaCofins;

end;

destructor TCofins01_02.Destroy;
begin
  FBaseCofins.Free;
  inherited;
end;

function TCofins01_02.ValorCofins: currency;
begin
  result := RoundABNT(BaseCofins * (FAliquotaCofins / 100),2);
end;

end.
