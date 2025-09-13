package com.immoplus.app.immoplus.services;
import com.immoplus.app.immoplus.entities.ContratLocation;
import com.immoplus.app.immoplus.entities.Paiement;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.resource.Emailv31;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.UUID;

public class MailerService {
    MailjetRequest request;
    MailjetResponse response;

    String apiKey = "4013a5cf42f2861b71484c78e783cce5";
    String apiSecret = "5febd12c2196a4f6fcaa82f962b8dc9d";
    String emailFrom = "zomethdev@gmail.com";
    MailjetClient client = new MailjetClient(apiKey,
            apiSecret);
    public void sendMail(ContratLocation contrat, Paiement paiement) throws MailjetException {

        UUID contratId = UUID.randomUUID();
        UUID paiementId = UUID.randomUUID();
        String content = """
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; background: #f6f6f6; margin: 0; padding: 0; }
                    .container { background: #fff; max-width: 600px; margin: 40px auto; border-radius: 8px; box-shadow: 0 2px 8px #e0e0e0; padding: 32px; }
                    h2 { color: #2d8f6f; }
                    .details { margin: 24px 0; }
                    .details th, .details td { padding: 8px 12px; text-align: left; }
                    .footer { color: #888; font-size: 12px; margin-top: 32px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h2>Paiement reçu avec succès !</h2>
                    <p>Bonjour %s,</p>
                    <p>Nous vous confirmons la réception de votre paiement pour le contrat de location <b>%s</b>.</p>
                    <table class="details">
                        <tr><th>Montant payé :</th><td>%.2f FCFA</td></tr>
                        <tr><th>Date du paiement :</th><td>%s</td></tr>
                        <tr><th>Référence du contrat :</th><td>%s</td></tr>
                        <tr><th>Référence du paiement :</th><td>%s</td></tr>
                    </table>
                    <p>Merci pour votre confiance.<br>L'équipe ImmoPlus</p>
                    <div class="footer">
                        Ceci est un message automatique, merci de ne pas répondre à cet email.
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                contrat.getLocataire().getNom(),
                contrat.getReference(),
                paiement.getMontant(),
                paiement.getDate().toString(),
                contrat.getReference(),
                paiement.getReference()
        );
        request = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", emailFrom)
                                        .put("Name", "ImmoPlus"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject()
                                                .put("Email", contrat.getLocataire().getEmail())
                                                .put("Name", contrat.getLocataire().getNom())))
                                .put(Emailv31.Message.SUBJECT, "Location - Paiement reçu")
                                .put(Emailv31.Message.TEXTPART, content)
                                .put(Emailv31.Message.HTMLPART, content)));
        response = client.post(request);
        System.out.println(response.getStatus());
        System.out.println(response.getData());
    }
    public void sendCancelContractMail(ContratLocation contrat) throws MailjetException {
        String content = """
            <html>
            <head>
                <style>
                    body { font-family: Arial, sans-serif; background: #f6f6f6; margin: 0; padding: 0; }
                    .container { background: #fff; max-width: 600px; margin: 40px auto; border-radius: 8px; box-shadow: 0 2px 8px #e0e0e0; padding: 32px; }
                    h2 { color: #d9534f; }
                    .footer { color: #888; font-size: 12px; margin-top: 32px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h2>Annulation de contrat</h2>
                    <p>Bonjour %s,</p>
                    <p>Nous vous informons que votre contrat de location <b>%s</b> a été annulé.</p>
                    <p>Pour toute question, veuillez contacter notre support.<br>L'équipe ImmoPlus</p>
                    <div class="footer">
                        Ceci est un message automatique, merci de ne pas répondre à cet email.
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                contrat.getLocataire().getNom(),
                contrat.getReference()
        );
        MailjetRequest cancelRequest = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", emailFrom)
                                        .put("Name", "ImmoPlus"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject()
                                                .put("Email", contrat.getLocataire().getEmail())
                                                .put("Name", contrat.getLocataire().getNom())))
                                .put(Emailv31.Message.SUBJECT, "Location - Annulation de contrat")
                                .put(Emailv31.Message.TEXTPART, "Votre contrat de location a été annulé.")
                                .put(Emailv31.Message.HTMLPART, content)));
        MailjetResponse cancelResponse = client.post(cancelRequest);
        System.out.println(cancelResponse.getStatus());
        System.out.println(cancelResponse.getData());
    }
}
