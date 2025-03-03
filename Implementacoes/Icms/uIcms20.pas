unit uIcms20;

interface

uses uBaseIcmsProprio, uValorIcms, uIIcms20;

type
  TIcms20 = class(TInterfacedObject, IIcms20)
  private
    FBaseReduzidaIcmsProprio: TBaseIcmsProprio;
    FValorIcms: TValorIcms;
    function BaseReduzidaIcmsProprio: currency;
    function ValorIcmsProprio: currency;
    function ValorIcmsDesonerado: currency;
  public
    constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto: currency;
                       _aliquotaIcms,
                       _percentualReducao: currency;
                       _valorIpi: currency = 0);
    destructor Destroy; override;

  end;

implementation

uses
  acbrutil.Math;

{ TIcms20 }

constructor TIcms20.Create(_valorProduto,
                           _valorFrete,
                           _valorSeguro,
                           _despesasAcessorias,
                           _valorDesconto,
                           _aLiquotaICMS,
                           _percentualReducao,
  _valorIpi: currency);
begin
  FBaseReduzidaIcmsProprio := TBaseIcmsProprio.Create(_valorProduto,
                                                      _valorFrete,
                                                      _valorSeguro,
                                                      _despesasAcessorias,
                                                      _valorDesconto,
                                                      _percentualReducao,
                                                      _valorIpi);

  FValorIcms := TValorIcms.Create(FBaseReduzidaIcmsProprio, _ALiquotaICMS);
end;

function TIcms20.BaseReduzidaIcmsProprio: currency;
begin
  Result := FBaseReduzidaIcmsProprio.CalcularBaseReduzida;
end;

function TIcms20.ValorIcmsProprio: currency;
begin
  Result := RoundABNT(FValorIcms.GetValorIcms,2);
end;

destructor TIcms20.Destroy;
begin
  FValorIcms.Free;
  FBaseReduzidaIcmsProprio.Free;
  inherited;
end;

function TIcms20.ValorIcmsDesonerado: currency;
var
 valorICMSNormal: currency;
begin
  valorICMSNormal :=  FValorIcms.CalcularValorNormalIcms;

  result := RoundABNT(valorICMSNormal - FValorIcms.GetValorIcms,2);
end;


end.
