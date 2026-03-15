package gapi

import (
	"fmt"

	db "github.com/indefinitee/simplebank/db/sqlc"
	"github.com/indefinitee/simplebank/pb"
	"github.com/indefinitee/simplebank/token"
	"github.com/indefinitee/simplebank/util"
	"github.com/indefinitee/simplebank/worker"
)

type Server struct {
	pb.UnimplementedSimpleBankServer
	config          util.Config
	store           db.Store
	tokenMaker      token.Maker
	taskDistributor worker.TaskDistributor
}

func NewServer(config util.Config, store db.Store, taskDistributor worker.TaskDistributor) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	s := &Server{
		config:          config,
		store:           store,
		tokenMaker:      tokenMaker,
		taskDistributor: taskDistributor,
	}

	return s, nil
}
