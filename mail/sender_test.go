package mail

import (
	"testing"

	"github.com/indefinitee/simplebank/util"
	"github.com/stretchr/testify/require"
)

func TestSenderEmailWithGmail(t *testing.T) {
	if testing.Short() {
		t.Skip()
	}

	config, err := util.LoadConfig("..")
	require.NoError(t, err)

	sender := NewGmailSender(config.EmailSenderName, config.EmailSenderAddress, config.EmailSenderPassword)

	subject := "test email"
	content := `
	<h1>Hello world</h1>
	<p>this is a test message</p>
	`

	to := []string{"test@gmail.com"}
	attachFiles := []string{"../start.sh"}

	err = sender.SendEmail(subject, content, to, nil, nil, attachFiles)
	require.NoError(t, err)
}
