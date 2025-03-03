unit uIcms202_203;

interface

uses uBaseIcmsProprio, uValorIcms, uBaseIcmsST, uValorIcmsST,  uIIcms202_203;

type
  TIcms202_203 = class(TInterfacedObject, IIcms202_203)
  private
    FBaseIcmsProprio: TBaseIcmsProprio;
    FIcmsProprio: TValorIcms;
    FBaseIcmsST: TBaseIcmsST;
    FIcmsST: TValorIcmsST;
  public
    constructor Create(_valorProduto,
                       _valorFrete,
                       _valorSeguro,
                       _despesasAcessorias,
                       _valorDesconto,
                       _aliquotaIcms,
                       _percentualReducao,
                       _aliquotaIcmsST,
                       _mva: currency;
                       _percentualReducaoST: currency = 0);
    function ValorBaseIcmsProprio: currency;
    function ValorIcmsProprio: currency;
    function ValorBaseIcmsST: currency;
    function ValorIcmsST: currency;
    destructor Destroy; override;


  end;

implementation
uses acbrutil.Math;

{ TIcms203 }

constructor TIcms202_203.Create(_valorProduto,
                            _valorFrete,
                            _valorSeguro,
                            _despesasAcessorias,
                            _valorDesconto,
                            _aliquotaIcms,
                            _percentualReducao,
                            _aliquotaIcmsST,
                            _mva,
                            _percentualReducaoST: currency);
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


end;

destructor TIcms202_203.Destroy;
begin
  FIcmsST.Free;
  FBaseIcmsST.Free;
  FIcmsProprio.Free;
  FBaseIcmsProprio.Free;
  inherited;
end;

function TIcms202_203.ValorBaseIcmsProprio: currency;
begin
  result := FBaseIcmsProprio.CalcularBaseIcmsProprio;
end;

function TIcms202_203.ValorBaseIcmsST: currency;
begin
  result := FBaseIcmsST.CalcularBaseIcmsST;
end;

function TIcms202_203.ValorIcmsProprio: currency;
begin
 result := RoundABNT(FIcmsProprio.GetValorIcms, 2);
end;

function TIcms202_203.ValorIcmsST: currency;
begin
  result := RoundABNT(FIcmsST.CalcularValorIcmsST,2);
end;

end.
