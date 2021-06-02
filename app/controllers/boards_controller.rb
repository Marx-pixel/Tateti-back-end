class BoardsController < ApplicationController
    skip_before_action :verify_authenticity_token

    respond_to :json    

    def player_start
        n = Player.count
        if n % 2 == 0
            board = Board.new
            board.save

            player = Player.new
            if player.save
                render(json: {id: player.id, nombre: player.nombre, board: board.id, squares: board.squares}, status: 200)
            else
                mesg = {message: [{
                    path: '/players',
                    message: player.errors.full_messages
                }]}
                render(json: mesg, status: 400)
            end
        else
            board = Board.last 
            player = Player.new
            if player.save
                render(json: {id: player.id, nombre: player.nombre, board: board.id, squares: board.squares}, status: 200)
            else
                mesg = {message: [{
                    path: '/players',
                    message: player.error.full_messages
                }]}
                render(json: mesg, status: 400)
            end
        end       
    end

    def game
        player = Player.find_by(id: params[:id])
        if player.present?
            board = Board.find_by(id: params[:board])
            if (player.nombre == "X" && board.xTurn == true) || (player.nombre == "O" && board.xTurn == false)
                if board.turnNumber < 7
                   board.stage_one(params[:y])
                else
                   board.stage_two(params[:u], params[:y])
                end
                render(json: {squares: board.squares, xTurn: board.xTurn, winner: board.winner, turnNumber: board.turnNumber}, status: 200)
            else
                mesg = "No es tu turno"
                render(json: {mensaje: mesg}, status: 403)
            end
            board.save
        else
            mesg = "El jugador no existe"
            render(json: {mensaje: mesg}, status: 403)
        end
    end

    def time_passes 
        board = Board.find_by(id: params[:board])
        if board.present?
            render(json: {squares: board.squares, xTurn: board.xTurn, winner: board.winner, turnNumber: board.turnNumber}, status: 200)
        else
            mesg = "El tablero no existe"
            render(json: {mensaje: mesg}, status: 410)
        end
    end

    def leave
        player = Player.find_by(id: params[:id])
        board = Board.find_by(id: params[:board])
        
        board.abandon
        player.destroy
        board.save

        render(json: {}, status: 200)
    end

    def game_over
        player = Player.find_by(id: params[:id])
        board = Board.find_by(id: params[:board])
        board.destroy
        player.destroy

        render(json: {}, status: 200)
    end
end