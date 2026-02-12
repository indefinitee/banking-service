package api

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	mock_db "github.com/indefinitee/simplebank/db/mock"
	db "github.com/indefinitee/simplebank/db/sqlc"
	"github.com/indefinitee/simplebank/util"
	"github.com/stretchr/testify/require"
	"go.uber.org/mock/gomock"
)

func TestGetAccountApi(t *testing.T) {
	// 1. Подготовка данных
	account := randomAccount()

	// 2. Настройка мока БД
	ctrl := gomock.NewController(t)
	defer ctrl.Finish()

	// 3. Ожидание: когда вызовут GetAccount с любым контекстом и ID=account.ID,
	//    вызвать 1 раз, вернуть account и nil
	store := mock_db.NewMockStore(ctrl)
	store.EXPECT().
		GetAccount(gomock.Any(), gomock.Eq(account.ID)).
		Times(1).
		Return(account, nil)

		// 4. Создаём сервер с мок-хранилищем
	server := NewServer(store)

	// 5. Создаём HTTP-запрос (НЕ отправляем по сети!)
	url := fmt.Sprintf("/accounts/%d", account.ID)
	request, err := http.NewRequest(http.MethodGet, url, nil)
	require.NoError(t, err)

	// 6. Создаём "перехватчик" ответа
	recorder := httptest.NewRecorder()

	// 7. ВЫЗЫВАЕМ ОБРАБОТЧИК НАПРЯМУЮ!
	server.router.ServeHTTP(recorder, request)

	// 8. Проверяем, что сервер ответил 200 OK
	require.Equal(t, http.StatusOK, recorder.Code)
}

func randomAccount() db.Account {
	return db.Account{
		ID:       util.RandomInt(1, 1000),
		Owner:    util.RandomCurrency(),
		Balance:  util.RandomMoney(),
		Currency: util.RandomCurrency(),
	}
}
