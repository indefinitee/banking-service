package api

import (
	"github.com/go-playground/validator/v10"
	"github.com/indefinitee/simplebank/util"
)

var validCurrency validator.Func = func(fl validator.FieldLevel) bool {
	fieldValue := fl.Field()

	interfaceValue := fieldValue.Interface()

	currency, ok := interfaceValue.(string)

	if !ok {
		return false
	}

	return util.IsSupportedCurrency(currency)
}
