# -*- coding: utf-8 -*-
module CsvHelper
    def testCSV(filepath, preferencias)
    result = Hash.new 
    names = Array.new
    #result[:status] = codigo de sucesso/falha
    #result[:text] = texto de falha
    #1º teste: integridade do arquivo
    begin
      CSV.foreach(filepath) do |row|
        row.each do |cell|
          test = cell #força a ler tudo
        end
      end
    rescue CSV::MalformedCSVError
      result[:status] = false
      result[:text] = "Arquivo invalido"
      return result
    end

    #2º teste: formato de arquivo
    row_number = 1
    CSV.foreach(filepath) do |row|
      unless (Aluno.classes.include? row[0])
        result[:status] = false
        result[:text] = "Classe invalida @ linha #{row_number}"
        return result
      end
      if (row[1].nil? || row[1] == "")
        result[:status] = false
        result[:text] = "Nome de aluno vazio @ linha #{row_number}"
        return result
      else
        names.push(row[1]) #para testar preferencias depois
      end
      unless (Aluno.sexos.include? row[2])
        result[:status] = false
        result[:text] = "Sexo invalido @ linha #{row_number}"
        return result
      end
      row_number += 1
    end
    #3º teste: preferencias sao validas
    if (preferencias == true)
      row_number = 1
      CSV.foreach(filepath) do |row|
        for i in 3..row.count
          unless names.include? row[i]
            #Se nao esta no excel pode estar ainda no banco
            begin
              aluno = Aluno.where("name = ?", row[i]).first!
            rescue ActiveRecord::RecordNotFound
              result[:status] = false
              result[:text] = "Aluno #{row[i]} nao existe no banco ou excel @ linha #{row_number}"
              return result
            end
          end
        end
        row_number += 1
      end
    end
    result[:status] = true
    return result
  end
end
