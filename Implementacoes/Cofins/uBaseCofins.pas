unit uBaseCofins;

interface
type
  TBaseCofins = class
  private
    FValorProduto: currency;
    FValorfrete: currency;
    FValorSeguro: currency;
    FDespesasAcessorias: currency;
    FValorDesconto: currency;

  public
    Constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto: currency);

    function CalcularBaseCofins: currency;
  end;

implementation
uses acbrutil.Math;

{ TBasePis }

constructor TBaseCofins.Create(_valorProduto,
                            _valorFrete,
                            _valorSeguro,
                            _despesasAcessorias,
                            _valorDesconto: currency);
begin
  FValorProduto := _valorProduto;
  FValorfrete := _valorFrete;
  FValorSeguro := _valorSeguro;
  FDespesasAcessorias := _despesasAcessorias;
  FValorDesconto := _valorDesconto;

end;

function TBaseCofins.CalcularBaseCofins: currency;
begin
   result := RoundABNT(FValorProduto +
                        FValorFrete +
                        FValorSeguro +
                        FDespesasAcessorias -
                        FValorDesconto, 2);
end;



end.
