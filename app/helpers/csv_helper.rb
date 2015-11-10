# -*- coding: utf-8 -*-
module CsvHelper
  def testCSV(filepath, preferencias)
    result = Hash.new 
    names = Array.new
    result[:text] = ""
    #result[:text] = explicacao de sucesso/falha
    #result[:status] = 0 := aprovado, 1:= aprovado com avisos, 2:= reprovado
    #1º teste: integridade do arquivo
    begin
      CSV.foreach(filepath) do |row|
        row.each do |cell|
          test = cell #força a ler tudo
        end
      end
    rescue CSV::MalformedCSVError
      result[:status] = 2
      result[:text] = "Arquivo invalido"
      return result
    end

    #2º teste: formato de arquivo
    row_number = 1
    CSV.foreach(filepath) do |row|
      unless (Aluno.classes.include? row[0])
        result[:status] = 2
        result[:text] = "Classe invalida @ linha #{row_number}"
        return result
      end
      if (row[1].nil? || row[1] == "")
        result[:status] = 2
        result[:text] = "Nome de aluno vazio @ linha #{row_number}"
        return result
      else
        names.push(row[1]) #para testar preferencias depois
      end
      unless (Aluno.sexos.include? row[2])
        result[:status] = 2
        result[:text] = "Sexo invalido @ linha #{row_number}"
        return result
      end
      row_number += 1
    end
    #3º teste: preferencias sao validas
    if preferencias
      row_number = 1
      CSV.foreach(filepath) do |row|
        (3..(row.count - 1)).each { |i|
          unless (names.include? row[i]) || (row[i].blank?)
            #preferencia vazia e' valida
            #Se nao esta no excel pode estar ainda no banco             
            begin
             aluno = Aluno.where("name = ?", row[i]).first!
           rescue ActiveRecord::RecordNotFound
             result[:status] = 1
             result[:text] += "<p>Aviso: Aluno #{row[i]} nao existe no banco ou excel @ linha #{row_number}, nao foi inserida preferencia</p>"
            end
          end
        }
        row_number += 1
      end
      if result[:status] == 1
        return result
      end
    end
    result[:status] = 0
    return result
  end
end
