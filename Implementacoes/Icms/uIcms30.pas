unit uIcms30;

interface

uses uBaseIcmsProprio, uValorIcms, uBaseIcmsST, uValorIcmsST,  uIIcms30;

type
  TIcms30 = class(TInterfacedObject, IIcms30)
  private
    FBaseIcmsProprio: TBaseIcmsProprio;
    FIcmsProprio: TValorIcms;
    FBaseIcmsST: TBaseIcmsST;
    FIcmsST: TValorIcmsST;
    function ValorBaseIcmsProprio: currency;
    function ValorIcmsProprio: currency;
    function ValorBaseIcmsST: currency;
    function ValorIcmsST: currency;
    function ValorIcmsDesonerado: currency;
  public
    constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto,
                       _aliquotaIcms,
                       _aliquotaIcmsST,
                       _mva: currency;
                       _percentualReducaoST: currency = 0;
                       _valorIpi: currency = 0);
     destructor Destroy; override;

  end;

implementation
uses acbrutil.Math;
{ TIcms10 }

constructor TIcms30.Create(_valorProduto,
                           _valorFrete,
                           _valorSeguro,
                           _despesasAcessorias,
                           _valorDesconto,
                           _aliquotaIcms,
                           _aliquotaIcmsST,
                           _mva,
                           _percentualReducaoST,
                           _valorIpi: currency);
begin
 FBaseIcmsProprio := TBaseIcmsProprio.Create(_valorProduto,
                           _valorFrete,
                           _valorSeguro,
                           _despesasAcessorias,
                           _valorDesconto);

 FIcmsProprio := TValorIcms.Create(FBaseIcmsProprio, _aliquotaIcms);

 FBaseIcmsST := TBaseIcmsST.Create(FBaseIcmsProprio, _mva, _percentualReducaoST);

 FIcmsST := TValorIcmsST.Create(FBaseIcmsST, _aliquotaIcmsST, FIcmsProprio);

end;

destructor TIcms30.Destroy;
begin
  FBaseIcmsProprio.Free;
  FIcmsProprio.Free;
  FBaseIcmsST.Free;
  FIcmsST.Free;
  inherited;
end;

function TIcms30.ValorBaseIcmsProprio: currency;
begin
  result := FBaseIcmsProprio.CalcularBaseIcmsProprio;
end;

function TIcms30.ValorIcmsProprio: currency;
begin

 result := RoundABNT(FIcmsProprio.GetValorIcms, 2);

end;

function TIcms30.ValorBaseIcmsST: currency;
begin
  result := FBaseIcmsST.CalcularBaseIcmsST;
end;


function TIcms30.ValorIcmsST: currency;
begin

 result := RoundABNT(FIcmsST.CalcularValorIcmsST,2);

end;

function TIcms30.ValorIcmsDesonerado: currency;
begin
  result := RoundABNT(FIcmsProprio.CalcularValorNormalIcms,2);
end;

end.
