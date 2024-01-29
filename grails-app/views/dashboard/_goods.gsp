<tr>
    <td><input id="good-name-input_${goodCount}" style="height: 5vh !important; width: 98%; border-radius: 4px;" name="good-unit-input_${goodCount}" value="${goods?.name}"/></td>
    <td>
        <g:select
                style="min-width: 13.9rem;border-radius: 0.3rem; width: 16%; min-height: 5vh; background-color: #eee2e2f2"
                data-ref="${goods?.id}"
                id="good-unit-input_${goodCount}"
                name='good-unit-input_${goodCount}'
                from="${['KG', 'CFT']}"
                value="${goods?.unit}"/>
    </td>
    <td><input type="number" style="height: 5vh !important; width: 98%; border-radius: 4px;" id="good-quantity-input_${goodCount}" name="good-quantity-input_${goodCount}"
               value="${goods?.quantity}"/>
    </td>
</tr>
<script>

</script>