package db

import (
	"context"
	"fmt"

	"github.com/jackc/pgx/v5"
)

func (s *SQLStore) execTx(ctx context.Context, fn func(*Queries) error) error {
	tx, err := s.connPool.BeginTx(ctx, pgx.TxOptions{})
	if err != nil {
		return err
	}

	q := New(tx)
	err = fn(q)
	if err != nil {
		if rbErr := tx.Rollback(ctx); rbErr != nil {
			return fmt.Errorf("tx rollback failed: %v\n\t rollback failed: %v", err, rbErr)
		}
		return err
	}

	return tx.Commit(ctx)
}
