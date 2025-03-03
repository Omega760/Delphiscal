unit uIcms201;

interface

uses uBaseIcmsProprio, uValorIcms, uBaseIcmsST, uValorIcmsST,  uIIcms201;

type
  TIcms201 = class(TInterfacedObject, IIcms201)
  private
    FBaseIcmsProprio: TBaseIcmsProprio;
    FIcmsProprio: TValorIcms;
    FBaseIcmsST: TBaseIcmsST;
    FIcmsST: TValorIcmsST;
    FPercentualCreditoSN: currency;
  public
    constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto,
                       _aliquotaIcms,
                       _percentualReducao,
                       _percentualCreditoSN,
                       _aliquotaIcmsST,
                       _mva: currency;
                       _percentualReducaoST: currency = 0);
    function ValorBaseIcmsProprio: currency;
    function ValorIcmsProprio: currency;
    function ValorBaseIcmsST: currency;
    function ValorIcmsST: currency;
    function ValorCreditoSN: currency;
    destructor Destroy; override;


  end;

implementation
uses acbrutil.Math;

{ TIcms201 }

constructor TIcms201.Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto,
                       _aliquotaIcms,
                       _percentualreducao,
                       _percentualCreditoSN,
                       _aliquotaIcmsST,
                       _mva: currency;
                       _percentualReducaoST: currency = 0);
begin

 FBaseIcmsProprio := TBaseIcmsProprio.Create(_valorProduto,
                           _valorFrete,
                           _valorSeguro,
                           _despesasAcessorias,
                           _valorDesconto,
                           _percentualReducao);

 FIcmsProprio := TValorIcms.Create(FBaseIcmsProprio, _aliquotaIcms);

 FBaseIcmsST := TBaseIcmsST.Create(FBaseIcmsProprio, _mva, _percentualReducaoST);

 FIcmsST := TValorIcmsST.Create(FBaseIcmsST, _aliquotaIcmsST, FIcmsProprio);

 FPercentualCreditoSN := _percentualCreditoSN;

end;

destructor TIcms201.Destroy;
begin
  FIcmsST.Free;
  FBaseIcmsST.Free;
  FIcmsProprio.Free;
  FBaseIcmsProprio.Free;
  inherited;
end;

function TIcms201.ValorBaseIcmsProprio: currency;
begin
  result := FBaseIcmsProprio.CalcularBaseIcmsProprio;
end;

function TIcms201.ValorBaseIcmsST: currency;
begin
  result := FBaseIcmsST.CalcularBaseIcmsST;
end;

function TIcms201.ValorCreditoSN: currency;
begin
  result := RoundABNT( ValorBaseIcmsProprio * (FPercentualCreditoSN / 100),2);
end;

function TIcms201.ValorIcmsProprio: currency;
begin
 result := RoundABNT(FIcmsProprio.GetValorIcms, 2);
end;

function TIcms201.ValorIcmsST: currency;
begin
  result := RoundABNT(FIcmsST.CalcularValorIcmsST,2);
end;

end.
