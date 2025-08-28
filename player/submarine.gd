extends RigidBody2D


@export var forca_propulsor: float = 600.0
@export var forca_manobra: float = 400.0

@onready var pos_propulsor_traseiro = $Sprite2D.get_rect().size.x / 2 * -1
@onready var pos_propulsor_frontal = $Sprite2D.get_rect().size.x / 2

func _physics_process(delta):
	# Zera o impulso rotacional a cada quadro para um controle mais direto
	# (opcional, mas ajuda a não girar fora de controle)
	set_angular_velocity(0)


	# Seta para CIMA: Ativa o propulsor traseiro para ir para FRENTE
	if Input.is_action_pressed("ui_up"):
		aplicar_forca_propulsor(forca_propulsor, pos_propulsor_traseiro)

	# Seta para BAIXO: Ativa o propulsor frontal para ir para TRÁS (ou frear)
	if Input.is_action_pressed("ui_down"):
		aplicar_forca_propulsor(-forca_propulsor * 0.7, pos_propulsor_frontal) # Um pouco mais fraco para ré

	# Seta para ESQUERDA: Ativa o propulsor de manobra frontal (empurra para baixo)
	if Input.is_action_pressed("ui_left"):
		aplicar_forca_manobra(-forca_manobra, pos_propulsor_frontal) # Empurra a frente para baixo, fazendo o submarino girar para a esquerda

	# Seta para DIREITA: Ativa o propulsor de manobra traseiro (empurra para baixo)
	if Input.is_action_pressed("ui_right"):
		aplicar_forca_manobra(+forca_manobra, pos_propulsor_traseiro) # Empurra a traseira para baixo, fazendo o submarino girar para a direita


# --- Funções Auxiliares ---

# Função para aplicar a força principal (frente/trás)
func aplicar_forca_propulsor(forca, posicao_x):
	# Cria um vetor de força na direção que o submarino está apontando
	var direcao_forca = Vector2.RIGHT.rotated(rotation) * forca
	# Define a posição de aplicação da força
	var posicao_aplicacao = Vector2(posicao_x, 0).rotated(rotation)
	
	# Aplica a força no ponto específico
	apply_force(direcao_forca, posicao_aplicacao)


# Função para aplicar a força de manobra (para rotação)
func aplicar_forca_manobra(forca, posicao_x):
	# Cria um vetor de força para baixo, relativo à rotação do submarino
	var direcao_forca = Vector2.DOWN.rotated(rotation) * forca
	# Define a posição de aplicação da força
	var posicao_aplicacao = Vector2(posicao_x, 0).rotated(rotation)

	# Aplica a força no ponto específico
	apply_force(direcao_forca, posicao_aplicacao)
