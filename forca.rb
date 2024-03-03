class Forca
  attr_reader :palavra_secreta, :palavra_descoberta, :tentativas_restantes, :letras_erradas

  def initialize(dificuldade, palavra = nil)
    @dificuldade = dificuldade
    @palavras_por_dificuldade = {
      facil: ["gato", "cachorro", "banana"],
      medio: ["elefante", "computador", "abacaxi"],
      dificil: ["hipopotamo", "aerodinamica", "ametropia"]
    }

    @palavra_secreta = palavra || selecionar_palavra_aleatoria
    @palavra_descoberta = "_" * @palavra_secreta.length
    @tentativas_restantes = dificuldade == :facil ? 8 : dificuldade == :medio ? 6 : 4
    @letras_erradas = []
  end

  def selecionar_palavra_aleatoria
    @palavras_por_dificuldade[@dificuldade].sample.downcase
  end

  def tentativa(letra)
    letra.downcase!
    if @palavra_secreta.include?(letra)
      @palavra_secreta.chars.each_with_index { |char, idx| @palavra_descoberta[idx] = char if char == letra }
    else
      @tentativas_restantes -= 1
      @letras_erradas << letra
    end
  end

  def jogo_acabou?
    @tentativas_restantes.zero? || @palavra_descoberta == @palavra_secreta
  end

  def pontos
    if @palavra_descoberta == @palavra_secreta
      @tentativas_restantes * 10
    else
      0
    end
  end
end

def mostrar_status(forca)
  puts "Palavra: #{forca.palavra_descoberta}"
  puts "Tentativas restantes: #{forca.tentativas_restantes}"
  puts "Letras erradas: #{forca.letras_erradas.join(', ')}"
end

def jogar_forca
  puts "Bem-vindo ao jogo da Forca!"
  puts "Escolha um nível de dificuldade (facil, medio, dificil):"
  dificuldade = gets.chomp.downcase.to_sym

  forca = Forca.new(dificuldade)

  until forca.jogo_acabou?
    puts "\n"
    mostrar_status(forca)
    puts "Digite uma letra:"
    forca.tentativa(gets.chomp)
  end

  puts "\n"
  mostrar_status(forca)

  if forca.palavra_descoberta == forca.palavra_secreta
    puts "Parabéns! Você ganhou!"
    puts "Pontuação: #{forca.pontos}"
  else
    puts "Você perdeu! A palavra era #{forca.palavra_secreta}."
  end
end

jogar_forca


