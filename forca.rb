class Forca
  attr_reader :palavra_secreta, :palavra_descoberta, :tentativas_restantes, :letras_erradas

  def initialize(palavra)
    @palavra_secreta = palavra.downcase
    @palavra_descoberta = "_" * palavra.length
    @tentativas_restantes = 6
    @letras_erradas = []
  end

  def tentativa(letra)
    letra = letra.downcase
    if @palavra_secreta.include?(letra)
      @palavra_secreta.chars.each_with_index do |char, idx|
        @palavra_descoberta[idx] = char if char == letra
      end
    else
      @tentativas_restantes -= 1
      @letras_erradas << letra
    end
  end

  def jogo_acabou?
    @tentativas_restantes.zero? || @palavra_descoberta == @palavra_secreta
  end
end

def mostrar_status(forca)
  puts "Palavra: #{forca.palavra_descoberta}"
  puts "Tentativas restantes: #{forca.tentativas_restantes}"
  puts "Letras erradas: #{forca.letras_erradas.join(', ')}"
end

def jogar_forca
  puts "Bem-vindo ao jogo da Forca!"
  puts "Digite uma palavra:"
  palavra = gets.chomp

  forca = Forca.new(palavra)

  until forca.jogo_acabou?
    puts "\n"
    mostrar_status(forca)
    puts "Digite uma letra:"
    letra = gets.chomp
    forca.tentativa(letra)
  end

  puts "\n"
  mostrar_status(forca)

  if forca.palavra_descoberta == forca.palavra_secreta
    puts "Parabéns! Você ganhou!"
  else
    puts "Você perdeu! A palavra era #{forca.palavra_secreta}."
  end
end

jogar_forca
