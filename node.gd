extends Node

const BABOONS = 20
var threads = []
var rope_direction : int  # 0 = south, 1 = north
var baboons_on_rope : int
var mutex = Mutex.new()

func _ready() -> void:
	randomize()
	rope_direction = 0
	baboons_on_rope = 0
	
	# Criando babuínos com direções aleatórias
	for i in range(BABOONS):
		var thread = Thread.new()
		thread.start(baboon_thread.bind(i, randi_range(0, 1)))
		threads.append(thread)

#Função necessária para finalização limpa na godot
func _exit_tree():
	for thread in threads:
		thread.wait_to_finish()

#Thread que representa o babuíno
func baboon_thread(baboon_id: int, direction: int) -> void:
	if direction == 1:
		_cross_north(baboon_id)
	else:
		_cross_south(baboon_id)

#Cruza a corda para o norte
func _cross_north(baboon_id: int) -> void:
	_enter_rope(baboon_id, 1)
	OS.delay_msec(3000)  # Crossing time
	_exit_rope(baboon_id, 1)

#Cruza a corda para o sul
func _cross_south(baboon_id: int) -> void:
	_enter_rope(baboon_id, 0)
	OS.delay_msec(3000)  # Crossing time
	_exit_rope(baboon_id, 0)

#Função que controla a entrada na corda
func _enter_rope(baboon_id: int, desired_direction: int) -> void:
	while true:
		mutex.lock()
		var can_enter = false
		
		#Primeiro a entrar designa a direção que a corda deve ser atravessada
		if baboons_on_rope == 0:
			rope_direction = desired_direction
			can_enter = true
		#Apenas babuínos que dejam ir para a mesma direção atual podem entrar
		elif baboons_on_rope < 5 and rope_direction == desired_direction:
			can_enter = true
			
		if can_enter:
			baboons_on_rope += 1
			print("B%d: Entering rope going %s (%d on rope)" % [
				baboon_id, 
				"NORTH" if desired_direction == 1 else "SOUTH",
				baboons_on_rope
			])
			mutex.unlock()
			return
			
		mutex.unlock()
		OS.delay_msec(100)  # Delay até tentar novamente

#Função que controla a saída da corda
func _exit_rope(baboon_id: int, direction: int) -> void:
	#Obtém o lock, diminui a contagem e libera novamente
	mutex.lock()
	baboons_on_rope -= 1
	print("B%d: Exited rope (%d remaining)" % [baboon_id, baboons_on_rope])
	mutex.unlock()
