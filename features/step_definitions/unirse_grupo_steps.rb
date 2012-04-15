# coding: utf-8
# language: es
Dado /^que Carlos está inscrito en Calculo II y OAC$/ do
  @carlos = User.new
  @calculoii = Group.new(name: "calculo2")
  @oac = Group.new(name: "OAC")
  @carlos.groups << @calculoii
  @carlos.groups << @oac
end